import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/product_list/cubits/product_search_state.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  ProductSearchCubit() : super(ProductSearchState(status: Status.pending));

  Future<void> searchProducts({
    String? categoryCode,
    Sort? sortBy,
  }) async {
    try {
      emit(state.copyWith(status: Status.pending));

      final searchResults =
          await GetIt.instance.get<ProductListApi>().searchProducts(
                categoryCode:
                    categoryCode ?? state.searchResults?.currentQuery.lastLeaf,
                sortBy: sortBy?.code,
              );
      final products = searchResults.products;

      emit(state.copyWith(
        status: Status.success,
        searchResults: searchResults,
        products: products,
      ));
    } on DioException catch (error) {
      emit(state.copyWith(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }
}
