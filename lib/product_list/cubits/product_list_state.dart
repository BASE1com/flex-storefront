import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductListState extends BlocState {
  final List<Product> products;

  ProductListState({
    required super.status,
    super.error,
    super.stackTrace,
    this.products = const [],
  });

  @override
  String toString() {
    return 'ProductListState{status: $status, products: ${products.length}}';
  }
}
