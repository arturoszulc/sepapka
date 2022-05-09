import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/foundation.dart';

class PurchaseService {

  final String _productID = "sepapka_pro";
  final InAppPurchase _iap = InAppPurchase.instance;
  String product = 'No products yet...';
  // checks if the API is available on this device
  bool isAvailable = false;
// keeps a list of products queried from Playstore or app store
  List<ProductDetails> _products = [];

  Future<void> checkIfStoreIsAvailable() async {
    isAvailable = await _iap.isAvailable();
  }

  Future<void> getUserProducts() async {
    Set<String> ids = {_productID};
    try {
      ProductDetailsResponse response = await _iap.queryProductDetails(ids);
      _products = response.productDetails;
      debugPrint('GOT PRODUCTS!!!!');
      debugPrint(_products.toString());
      debugPrint('Product title: ${_products[0].title}');
      debugPrint('Product price: ${_products[0].price}');
      debugPrint('Product price raw: ${_products[0].rawPrice}');
      debugPrint('Product currency: ${_products[0].currencyCode}');
      product = _products[0].title;
    } catch (e) {
      debugPrint('### Error getting Products from Google Play Store');
      debugPrint(e.toString());
      product = 'No products found!';
    }
  }
//just pasted it
  void buyProduct(ProductDetails prod){
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }


}