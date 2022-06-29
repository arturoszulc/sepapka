import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/product_wrapper.dart';

enum PurchaseStatus {
  loading,
  error,
  initialized,
  pending,
  finished,
}

class PurchaseStateModel {
  final PurchaseStatus status;
  final String error;
  final Package? package;
  final Product? product;


  const PurchaseStateModel({
    required this.status,
    required this.error,
    this.package,
    this.product,
  });

  factory PurchaseStateModel.init() {
    return const PurchaseStateModel(status: PurchaseStatus.loading, error: '');
  }

  PurchaseStateModel copyWith({
    PurchaseStatus? status,
    String? error,
    Package? package,
    Product? product,
  }) {
    return PurchaseStateModel(
      status: status ?? this.status,
      error: error ?? this.error,
      package: package ?? this.package,
      product: product ?? this.product,
    );
  }
}
