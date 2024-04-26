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
    FacetValue? filterBy,
  }) async {
    try {
      emit(state.copyWith(status: Status.pending));

      // build our hybris-specific query string
      // TODO: this is really gross, split it out into multiple cubit methods
      // that way we can also test them separately, and log events for each
      final currentQuery = state.searchResults?.currentQuery;
      String query;
      if (filterBy != null) {
        query = filterBy.query.value;
      } else if (sortBy != null) {
        query =
            ':${sortBy.code}:${currentQuery?.withoutSort ?? 'allCategories:${categoryCode ?? currentQuery?.lastLeaf}'}';
      } else {
        query = ':relevance:allCategories:$categoryCode';
      }

      final searchResults = await GetIt.instance
          .get<ProductListApi>()
          .searchProducts(query: query);
      final facets = searchResults.facets
        ..sort((a, b) => a.priority.compareTo(b.priority));
      final products = searchResults.products;

      emit(state.copyWith(
        status: Status.success,
        searchResults: searchResults,
        facets: facets,
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
