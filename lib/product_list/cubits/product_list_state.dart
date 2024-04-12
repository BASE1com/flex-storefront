import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductListState extends BlocState {
  final SearchResults? searchResults;
  final List<Product> products;

  ProductListState({
    required super.status,
    super.error,
    super.stackTrace,
    this.searchResults,
    this.products = const [],
  });

  @override
  String toString() {
    return 'ProductListState{status: $status, products: ${products.length}}';
  }
}
