import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/search/models/search_results.dart';

enum ProductSearchStatus {
  initial,
  pending,
  failure,
  success,
  pagePending,
}

class ProductSearchState {
  final ProductSearchStatus status;
  final List<Breadcrumb> breadcrumbs;
  final List<Facet> facets;
  final List<Product> products;
  final Pagination pagination;
  final SearchResults? searchResults;

  ProductSearchState({
    required this.status,
    this.breadcrumbs = const [],
    this.facets = const [],
    this.products = const [],
    required this.pagination,
    this.searchResults,
  });

  ProductSearchState copyWith({
    ProductSearchStatus? status,
    Object? error,
    StackTrace? stackTrace,
    List<Breadcrumb>? breadcrumbs,
    List<Facet>? facets,
    List<Product>? products,
    Pagination? pagination,
    SearchResults? searchResults,
  }) {
    return ProductSearchState(
      status: status ?? this.status,
      breadcrumbs: breadcrumbs ?? this.breadcrumbs,
      facets: facets ?? this.facets,
      products: products ?? this.products,
      pagination: pagination ?? this.pagination,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  String toString() {
    return 'ProductSearchState{status: $status, '
        'breadcrumbs: ${breadcrumbs.length}, facets: ${facets.length}, '
        'pagination: $pagination, products: ${products.length}}';
  }
}
