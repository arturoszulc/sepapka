import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sepapka/utils/api_status.dart';

class PurchaseService {
  static const String _googleApiKey = 'goog_BqkJbAyuNBMUrdkvOSXpxakljWH';
  final String productId = 'sepapka_pro_v1';
  List<Package> packages = [];
  Package? package;
  Product? product;

  Future<Object> init(String userId) async {
    try {
      await Purchases.setDebugLogsEnabled(true);
      await Purchases.setup(_googleApiKey, appUserId: userId);
      return Success();
    }
    // catch (e) {
    //   return Failure('### PurchaseService init ERROR: ${e.toString()} ###');
    // }
    on PlatformException catch (e) {
      return Failure('${e.code}, ${e.message}');
    }
  }

  Future<Object> getOffers() async {
    debugPrint('*** _purchaseService getOffers() deployed ***');
    try {
      final Offerings offerings = await Purchases.getOfferings();
      if (offerings.current == null) return Failure('### No offers found ###');
      packages = offerings.current?.availablePackages ?? [];
      package = packages.firstWhereOrNull((e) => e.product.identifier == productId);
      if (package == null) return Failure('36, Nie znaleziono produktu');
      product = package!.product;
      return Success();
    } on PlatformException catch (e) {
      return Failure('${e.code}, ${e.message}');
    }
  }

  Future<Object> checkIfPurchaseWasMade() async {
    try {
      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      debugPrint('### Purchaser info:: ${purchaserInfo}');
      bool? isPurchased = purchaserInfo.entitlements.active["Pro"]?.isActive;
      if (isPurchased != null && isPurchased){
        return purchaserInfo.entitlements.all['Pro']!;

      }
      return Failure();
    } on PlatformException catch (e) {
      // Error restoring purchases
      debugPrint('### RestorPurchases Error: ${e.toString()}');
      return Failure();
    }
  }

  Future<Object> buyProduct() async {
    //some users may stay on the PurchaseScreen and try to click on buy button.
    //In order to prevent user from buying the same product again, I am checking if the previous
    //payment was finished (just in case)
    Object wasPurchaseMade = await checkIfPurchaseWasMade();
    if (wasPurchaseMade is EntitlementInfo) {
      return wasPurchaseMade;
    }
    //if there was no payment earlier, procceed
    try {
      PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package!);
      if (purchaserInfo.entitlements.all["Pro"]!.isActive) {
        debugPrint('@@@ PURCHASE CONFIRMED @@@');
        return purchaserInfo.entitlements.all['Pro']!;
      }
      else {
        return Failure('### Nie znaleziono entitlement ID ###');
      }
    } on PlatformException catch (e) {
      debugPrint('### BuyError: ${e.toString()}');
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      return errorCode;
    }
  }

  addIdToRevenueCat(String userId) {
    debugPrint('*** Adding ID to RevenueCat... ***');
    Purchases.setAttributes({ 'userId' : userId});
  }

}
