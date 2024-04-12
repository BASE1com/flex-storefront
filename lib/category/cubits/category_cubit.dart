import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/category/apis/category_api.dart';
import 'package:flex_storefront/category/cubits/category_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState(status: Status.pending));

  Future<void> loadCategories({int? parentId}) async {
    try {
      emit(CategoryState(status: Status.pending));

      final categories =
          await GetIt.instance.get<CategoryApi>().fetchRootCategories();

      emit(CategoryState(
        status: Status.success,
        categories: categories,
      ));
    } on DioException catch (error) {
      emit(CategoryState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }
}
