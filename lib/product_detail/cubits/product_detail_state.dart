import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductDetailState {
  final Status status;
  final Product? product;
  final int quantity;

  ProductDetailState({
    required this.status,
    this.product,
    this.quantity = 1,
  });

  ProductDetailState copyWith({
    Status? status,
    Product? product,
    int? quantity,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'ProductDetailState{status: $status, product: $product, quantity: $quantity}';
  }
}
