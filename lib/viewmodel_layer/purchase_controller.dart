import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sepapka/model_layer/models/purchase_state_model.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/purchase_service.dart';

import '../model_layer/services/user_service.dart';
import '../utils/api_status.dart';


final purchaseController = StateNotifierProvider.autoDispose<PurchaseController, PurchaseStateModel>((ref) => PurchaseController(ref));

class PurchaseController extends StateNotifier<PurchaseStateModel>{
  final Ref _ref;
  PurchaseController(this._ref) :super(PurchaseStateModel.init()) {
   log('^^^ PurchaseController initialized^^^');
   revenueCatStart();
  }

  resetPurchaseController() {
    state = PurchaseStateModel.init();
  }
  setPurchaseError(String? error) {
    state = state.copyWith(error: error ?? '');
  }

  revenueCatStart() async {
    // navigate(MyScreen.loading);
    // Timer(const Duration(seconds: 2), () {});
    Object initResult = await _ref.read(purchaseService).init();
    if (initResult is Failure) {
      log(initResult.errorString.toString());
      setPurchaseError(initResult.errorString);
      state = state.copyWith(status: PurchaseStatus.error);
      return;
    }
    Object getPackage = await _ref.read(purchaseService).getOffers();
    if (getPackage is Failure) {
      log(getPackage.errorString.toString());
      setPurchaseError(getPackage.errorString);
      state = state.copyWith(status: PurchaseStatus.error);
      return;
    }
    if (getPackage is Package) state = state.copyWith(package: getPackage, product: getPackage.product);

    Object isPurchaseFinished = await _ref.read(purchaseService).checkIfPurchaseWasMade();
    if (isPurchaseFinished is EntitlementInfo) {
      log('@@@ PURCHASE CONFIRMED @@@');
      finishPurchase(isPurchaseFinished);
      return;
    }
    state = state.copyWith(status: PurchaseStatus.initialized);

  }

  buyProduct() async {
    Object buyResult = await _ref.read(purchaseService).buyProduct(state.package!);
    if (buyResult is EntitlementInfo) {
      log('### Buy product SUCCEEDED! ###');
      finishPurchase(buyResult);
    } else {
      log('### PURCHASE ERROR ###');
      handlePurchaseError(buyResult);
    }

  }

  //DATA OF PURCHASER INFO
  //I/flutter (15692): ### Purchaser info::
  // EntitlementInfos(
  // all: {
  // Pro: EntitlementInfo(
  // identifier: Pro,
  // isActive: true,
  // willRenew: false,
  // latestPurchaseDate: 2022-05-25T11:14:24.000Z,
  // originalPurchaseDate: 2022-05-25T11:14:24.000Z,
  // productIdentifier: sepapka_pro_v1,
  // isSandbox: true,
  // ownershipType: OwnershipType.unknown,
  // store: Store.playStore,
  // periodType: PeriodType.normal,
  // expirationDate: null,
  // unsubscribeDetectedAt: null,
  // billingIssueDetectedAt: null)},
  // active: {
  // Pro: EntitlementInfo(
  // identifier: Pro,
  // isActive: true,
  // willRenew: false,
  // latestPurchaseDate: 2022-05-25T11:14:24.000Z,
  // originalPurchaseDate: 2022-05-25T11:14:24.000Z,
  // productIdentifier: sepapka_pro_v1,
  // isSandbox: true,
  // ownershipType: OwnershipType.unknown,
  // store: Store.playStore,
  // periodType: PeriodType.normal,
  // expirationDate: null,
  // unsubscribeDetectedAt: null,
  // billingIssueDetectedAt: null)})


  finishPurchase(EntitlementInfo info) async {
    final String userId = _ref.read(userService).id;

    //add userID to revenueCat
    _ref.read(purchaseService).addIdToRevenueCat(userId);

    //save purchase details
    _ref.read(databaseService).savePurchaseDetails(info, userId);
    //give user pro permission
    setPurchaseError(null);
    _ref.read(userService.notifier).goPro();
    state = state.copyWith(status: PurchaseStatus.finished);

  }

  handlePurchaseError(Object errorCode) {
    if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
      log('### purchase cancelled');
    }
    if (errorCode == PurchasesErrorCode.paymentPendingError) {
      log('### payment pending');
      state = state.copyWith(status: PurchaseStatus.pending);
    }
    if (errorCode == PurchasesErrorCode.networkError) {
      log('### network error');
    }
    if (errorCode == PurchasesErrorCode.storeProblemError) {
      log('### store problem error');
    }
  }


// purchasePatronite(String email) async {
//   String? verifyEmailResult = await _databaseService.verifyPatroniteEmail(email);
//   if (verifyEmailResult == null) {
//     setError(Failure('Nie znaleziono Patrona z takim adresem e-mail'));
//     navigate(Screen.purchasePatronite);
//   } else {
//     setError(null);
//     await goPro();
//     navigate(Screen.purchaseSuccess);
//   }
// }

}