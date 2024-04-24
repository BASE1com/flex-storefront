import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductSearchState extends BlocState {
  final List<Product> products;
  final SearchResults? searchResults;

  ProductSearchState({
    required super.status,
    super.error,
    super.stackTrace,
    this.products = const [],
    this.searchResults,
  });

  ProductSearchState copyWith({
    Status? status,
    Object? error,
    StackTrace? stackTrace,
    List<Product>? products,
    SearchResults? searchResults,
  }) {
    return ProductSearchState(
      status: status ?? this.status,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      products: products ?? this.products,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  String toString() {
    return 'ProductSearchState{status: $status, products: ${products.length}}';
  }
}
