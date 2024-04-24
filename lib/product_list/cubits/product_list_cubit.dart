import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListState(status: Status.pending));

  Future<void> loadProducts({String? categoryCode}) async {
    try {
      emit(ProductListState(status: Status.pending));

      final searchResults = await GetIt.instance
          .get<ProductListApi>()
          .fetchProducts(categoryCode: categoryCode);

      emit(ProductListState(
        status: Status.success,
        products: searchResults.products,
      ));
    } on DioException catch (error) {
      emit(ProductListState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }
}
