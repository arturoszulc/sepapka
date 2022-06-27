import 'package:purchases_flutter/models/product_wrapper.dart';

enum PurchaseStatus {
  loading,
  error,
  initialized,
  finished,
}

class PurchaseStateModel {
  final PurchaseStatus status;
  final String error;
  final Product? product;

  const PurchaseStateModel({
    required this.status,
    required this.error,
    this.product,
  });

  factory PurchaseStateModel.init() {
    return const PurchaseStateModel(status: PurchaseStatus.loading, error: '');
  }

  PurchaseStateModel copyWith({
    PurchaseStatus? status,
    String? error,
    Product? product,
  }) {
    return PurchaseStateModel(
      status: status ?? this.status,
      error: error ?? this.error,
      product: product ?? this.product,
    );
  }
}
