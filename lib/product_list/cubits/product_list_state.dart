import 'package:flex_storefront/product_list/models/product.dart';

enum ProductListStatus {
  pending,
  success,
  failure,
}

class ProductListState {
  final ProductListStatus status;
  final List<Product> products;

  ProductListState({
    required this.status,
    this.products = const [],
  });

  @override
  String toString() {
    return 'ProductListState{status: $status, products: ${products.length}}';
  }
}
