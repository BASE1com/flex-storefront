import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/product_list/cubits/product_search_state.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  ProductSearchCubit()
      : super(ProductSearchState(
          status: Status.pending,
          pagination: Pagination.empty(),
        ));

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

      // sort the facets by priority
      final facets = searchResults.facets
        ..sort((a, b) => a.priority.compareTo(b.priority));

      emit(state.copyWith(
        status: Status.success,
        searchResults: searchResults,
        breadcrumbs: searchResults.breadcrumbs,
        facets: facets,
        pagination: searchResults.pagination,
        products: searchResults.products,
      ));
    } on DioException catch (error) {
      emit(state.copyWith(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }

  Future<void> nextPage() async {
    if (state.pagination.currentPage + 1 >= state.pagination.totalPages ||
        state.searchResults == null ||
        state.status == Status.pending) {
      return;
    }

    try {
      // todo: discuss how to handle item pending state
      // emit(state.copyWith(status: Status.pending));

      final searchResults =
          await GetIt.instance.get<ProductListApi>().searchProducts(
                query: state.searchResults!.currentQuery.value,
                page: state.pagination.currentPage + 1,
              );

      emit(state.copyWith(
        status: Status.success,
        searchResults: searchResults,
        breadcrumbs: searchResults.breadcrumbs,
        facets: searchResults.facets,
        pagination: searchResults.pagination,
        products: [...state.products, ...searchResults.products],
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
