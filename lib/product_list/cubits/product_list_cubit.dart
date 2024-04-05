import 'package:bloc/bloc.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductListApi productListApi = ProductListApi();

  ProductListCubit()
      : super(ProductListState(status: ProductListStatus.pending));

  Future<void> loadProducts({String? categoryId}) async {
    try {
      emit(ProductListState(status: ProductListStatus.pending));

      final searchResults = await productListApi.fetchProducts();
      final products = searchResults.products;

      emit(ProductListState(
        status: ProductListStatus.success,
        products: products,
      ));
    } catch (err) {
      emit(ProductListState(status: ProductListStatus.failure));
    }
  }
}
