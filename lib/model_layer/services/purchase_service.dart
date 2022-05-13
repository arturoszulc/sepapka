import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService {

  static const String _googleApiKey = 'goog_BqkJbAyuNBMUrdkvOSXpxakljWH';
  List<Package>? packages;

  Future<void> init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_googleApiKey);
  }

  Future<void> getOffers() async {
    debugPrint('*** GETTING OFFERRS ***');
    try {
      final Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        //print offerings
        packages = offerings.current?.availablePackages;
      }
      // final Offering? current = offerings.current;
      // return current == null ? [] : [current];
    // } on PlatformException catch (e) {
    //   debugPrint('getOffers() error: ${e.toString()}');
    //   // return [];
    // } on Error catch (e) {
    //   debugPrint('**CATCHED ERROR**: ${e.toString()}');
    } catch (e) {
        debugPrint('getOffers() error: ${e.toString()}');
    }
  }

  Future<void> buyProduct() async {
    // try {
    //   PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package);
    //   if (purchaserInfo.entitlements.all["my_entitlement_identifier"].isActive) {
    //     // Unlock that great "pro" content
    //   }
    // } on PlatformException catch (e) {
    //   var errorCode = PurchasesErrorHelper.getErrorCode(e);
    //   if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
    //     showError(e);
    //   }
    // }
  }



  // OLD IN APP PURCHASES
//
//   //main instance
//   final InAppPurchase _iap = InAppPurchase.instance;
//   bool isStoreAvailable = false;
//   StreamController<bool> _purchaseController = StreamController<bool>();
//
//   Stream<bool> get purchaseStream => _purchaseController.stream;
//
//   //unique product ID
//   final String _productID = "sepapka_pro_test2";
//
//   //retrieved product name goes here
//   String productName = 'No products yet...';
//   String productPrice = '';
//
//   List<PurchaseDetails?> purchaseList = [];
//
//   //if user has purchased, save the details
//   PurchaseDetails? purchaseDetails;
//
// // keeps a list of products queried from Playstore or AppStore
//   List<ProductDetails> _products = [];
//
//   StreamSubscription? subscription;
//
//   Future<Object> initialize() async {
//     await checkIfStoreIsAvailable();
//     if (!isStoreAvailable) return Failure('### ERROR: Store is not available ###');
//     rebuildStreamController();
//     await getUserProducts();
//     if (_products.isEmpty) {
//       return Failure('No products found');
//     }
//     //verify on initialize to solve any pending purchases
//     //monitor everything user has bought and add it to list
//     subscription = _iap.purchaseStream.listen((List<PurchaseDetails> list) {
//       debugPrint('*** Purchase stream updated!!! ***');
//       purchaseList.addAll(list);
//       debugPrint('Number of purchases send through stream: ${list.length}');
//       verifyPurchase();
//       // Object verifyResult = verifyPurchase();
//       // if (verifyResult is Failure) return verifyResult;
//     });
//     _iap.restorePurchases();
//     return Success();
//   }
//
//   rebuildStreamController() {
//     _purchaseController.close();
//     _purchaseController = StreamController<bool>();
//   }
//
//   closeStore() async {
//     _purchaseController.close();
//     debugPrint('Is purchaseController closed? ${_purchaseController.isClosed}');
//     await subscription?.cancel();
//     // subscription = null;
//     // debugPrint(subscription.resume());
//   }
//
//   verifyPurchase() async {
//     for (PurchaseDetails? purchase in purchaseList) {
//       debugPrint('Another purchase');
//       if (purchase != null) {
//         debugPrint('PurchaseID: ${purchase.purchaseID}');
//         debugPrint('PurchaseStatus: ${purchase.status}');
//         debugPrint('PurchasePendingComplete: ${purchase.pendingCompletePurchase}');
//         purchaseDetails = purchase;
//       }
//
//       switch (purchaseDetails?.status) {
//         case PurchaseStatus.pending:
//           debugPrint('*** verifyPurchase(): Purchase PENDING ***');
//           debugPrint('Status: ${purchaseDetails!.status}');
//           debugPrint('PendingComplete?: ${purchaseDetails!.pendingCompletePurchase.toString()}');
//           break;
//         case PurchaseStatus.purchased:
//           debugPrint('*** verifyPurchase(): Purchase COMPLETED ***');
//           if (purchaseDetails != null && purchaseDetails!.pendingCompletePurchase) {
//             debugPrint('Completing Purchase...');
//             await _iap.completePurchase(purchaseDetails!);
//           }
//           subscription?.cancel();
//           _purchaseController.add(true);
//           break;
//         case PurchaseStatus.error:
//           debugPrint('### ERROR: Something went wrong with the purchase... ###');
//           break;
//         case PurchaseStatus.restored:
//           debugPrint('*** verifyPurchase(): Purchase RESTORED ***');
//           break;
//         case PurchaseStatus.canceled:
//           debugPrint('*** verifyPurchase(): Purchase CANCELED ***');
//           debugPrint('Status: ${purchaseDetails!.status}');
//           debugPrint('PendingComplete?: ${purchaseDetails!.pendingCompletePurchase.toString()}');
//           break;
//         case null:
//           debugPrint('*** verifyPurchase(): Purchase is NULL ***');
//       }
//
//     }
//     purchaseList.clear();
//   }
//
//   Future<void> checkIfStoreIsAvailable() async {
//     isStoreAvailable = await _iap.isAvailable();
//   }
//
//   Future<void> getUserProducts() async {
//     Set<String> ids = {_productID};
//     ProductDetailsResponse response = await _iap.queryProductDetails(ids);
//     _products = response.productDetails;
//     if (_products.isNotEmpty) {
//       debugPrint('getProducts: SUCCESS');
//       productPrice = _products[0].rawPrice.toString();
//       productName = _products[0].title;
//     }
//   }
//
//   void buyProduct() {
//     final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products[0]);
//     _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
//   }


}
