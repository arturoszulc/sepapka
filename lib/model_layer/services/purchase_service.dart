import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:collection/collection.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../../utils/api_status.dart';

class PurchaseService {
  //main instance
  final InAppPurchase _iap = InAppPurchase.instance;
  bool isStoreAvailable = false;
  final StreamController<bool> _purchaseController = StreamController<bool>();

  Stream<bool> get purchaseStream => _purchaseController.stream;

  //unique product ID
  final String _productID = "sepapka_pro_test";

  //retrieved product name goes here
  String productName = 'No products yet...';
  String productPrice = '';

  List<PurchaseDetails?> purchaseList = [];

  //if user has purchased, save the details
  PurchaseDetails? purchaseDetails;

// keeps a list of products queried from Playstore or AppStore
  List<ProductDetails> _products = [];

  StreamSubscription? subscription;

  Future<Object> initialize() async {
    _purchaseController.add(false);
    await checkIfStoreIsAvailable();
    if (isStoreAvailable) {
      await getUserProducts();
      if (_products.isEmpty) {
        return Failure('No products found');
      }
      // await InAppPurchase.instance.restorePurchases();
      //monitor everything user has bought and add it to list
      subscription = _iap.purchaseStream.listen((List<PurchaseDetails> list) {
        debugPrint('*** Purchase stream updated!!! ***');
        purchaseList.addAll(list);
        verifyPurchase();
      });
      return Success();
    }
    else {
      return Failure('Store is not available');
    }
  }

  closeStore() async {
    // _purchaseController.close().then((_) {
    //   debugPrint('purchaseController hasListener? ${_purchaseController.hasListener}');
    // });
    // await subscription?.cancel();
    // subscription = null;
    // debugPrint(subscription.resume());
  }

  void verifyPurchase() {
    purchaseDetails =
        purchaseList.firstWhereOrNull((purchase) => purchase?.productID == _productID);
    if (purchaseDetails != null) {
      debugPrint('Got purchaseDetails');
      if (purchaseDetails?.status == PurchaseStatus.purchased) {
        debugPrint('*** User has purchased something!!!');

        if (purchaseDetails!.pendingCompletePurchase) {
          _iap.completePurchase(purchaseDetails!);
          subscription?.cancel();
          _purchaseController.add(true);
        }
      }
      if (purchaseDetails?.status == PurchaseStatus.error) {
        debugPrint('### Purchase status is ERROR###');
      }
    }
  }

  Future<void> checkIfStoreIsAvailable() async {
    isStoreAvailable = await _iap.isAvailable();
    if (isStoreAvailable) {
      debugPrint('*** Store is available ***');
    }
  }

  Future<void> getUserProducts() async {
    Set<String> ids = {_productID};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    _products = response.productDetails;
    if (_products.isNotEmpty) {
      debugPrint('getProducts: SUCCESS');
      productPrice = _products[0].rawPrice.toString();
      productName = _products[0].title;
    }
  }

    void buyProduct() {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products[0]);
      _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    }
  }
