import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';
import 'package:flex_storefront/search/models/search_results.dart';
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
      final products = searchResults.products;

      emit(ProductListState(
        status: Status.success,
        searchResults: searchResults,
        products: products,
      ));
    } on DioException catch (error) {
      emit(ProductListState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }

  Future<void> sortProducts(
      {String? categoryCode, required Sort sortBy}) async {
    try {
      emit(ProductListState(
        status: Status.pending,
        searchResults: state.searchResults,
        products: state.products,
      ));

      final searchResults =
          await GetIt.instance.get<ProductListApi>().fetchProducts(
                categoryCode: state.searchResults!.currentQuery.lastLeaf,
                sortBy: sortBy.code,
              );
      final products = searchResults.products;

      emit(ProductListState(
        status: Status.success,
        searchResults: searchResults,
        products: products,
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
