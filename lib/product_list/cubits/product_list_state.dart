import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/search/models/search_results.dart';

enum ProductListStatus {
  pending,
  success,
  failure,
}

class ProductListState {
  final ProductListStatus status;
  final SearchResults? searchResults;
  final List<Product> products;

  ProductListState({
    required this.status,
    this.searchResults,
    this.products = const [],
  });

  @override
  String toString() {
    return 'ProductListState{status: $status, products: ${products.length}}';
  }
}
