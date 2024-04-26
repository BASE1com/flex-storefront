import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductSearchState extends BlocState {
  final List<Facet> facets;
  final List<Product> products;
  final SearchResults? searchResults;

  ProductSearchState({
    required super.status,
    super.error,
    super.stackTrace,
    this.facets = const [],
    this.products = const [],
    this.searchResults,
  });

  ProductSearchState copyWith({
    Status? status,
    Object? error,
    StackTrace? stackTrace,
    List<Facet>? facets,
    List<Product>? products,
    SearchResults? searchResults,
  }) {
    return ProductSearchState(
      status: status ?? this.status,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      facets: facets ?? this.facets,
      products: products ?? this.products,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  String toString() {
    return 'ProductSearchState{status: $status, facets: ${facets.length}, products: ${products.length}}';
  }
}
