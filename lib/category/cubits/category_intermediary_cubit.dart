import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/category/apis/category_api.dart';
import 'package:flex_storefront/category/cubits/category_intermediary_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class CategoryIntermediaryCubit extends Cubit<CategoryIntermediaryState> {
  CategoryIntermediaryCubit()
      : super(CategoryIntermediaryState(status: Status.pending));

  Future<void> loadCategory({required int categoryId}) async {
    try {
      emit(CategoryIntermediaryState(status: Status.pending));

      final category = await GetIt.instance
          .get<CategoryApi>()
          .fetchCategory(categoryId: categoryId);

      emit(CategoryIntermediaryState(
        status: Status.success,
        category: category,
      ));
    } on DioException catch (error) {
      emit(CategoryIntermediaryState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }
}
