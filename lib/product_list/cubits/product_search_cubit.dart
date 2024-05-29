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
          status: Status.initial,
          pagination: Pagination.empty(),
        ));

  Future<void> searchProductsAutocomplete({
    required String query,
  }) async {
    emit(state.copyWith(status: Status.pending));

    final searchResults = await GetIt.instance
        .get<ProductListApi>()
        .searchProducts(query: query, limit: 5);

    emit(state.copyWith(
      status: Status.success,
      searchResults: searchResults,
      products: searchResults.products,
    ));
  }

  Future<void> searchProducts({
    String? searchTerm,
    String? categoryCode,
    Sort? sortBy,
    FacetValue? filterBy,
  }) async {
    try {
      emit(state.copyWith(status: Status.pending));

      final currentQuery = state.searchResults?.currentQuery;
      String query;
      if (filterBy != null) {
        // For each facet value, hybris provides the pre-built query to use
        // when the user selects this facet value.
        query = filterBy.query.value;
      } else if (sortBy != null) {
        // For the sort, we generate the query ourself (not too complex)
        query = currentQuery!.copyWithSort(sortBy.code);
      } else {
        // First query of this cubit instance:
        query =
            '${searchTerm ?? ''}:relevance${categoryCode != null ? ':allCategories:$categoryCode' : ''}';
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
      emit(state.copyWith(status: Status.pending));

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
