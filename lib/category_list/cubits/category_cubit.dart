import 'package:bloc/bloc.dart';
import 'package:flex_storefront/category_list/apis/category_api.dart';
import 'package:flex_storefront/category_list/cubits/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryApi categoryApi = CategoryApi();

  CategoryCubit() : super(CategoryState(status: CategoryStatus.pending));

  Future<void> loadCategories({int? parentId}) async {
    try {
      emit(CategoryState(status: CategoryStatus.pending));

      final categories = await categoryApi.fetchCategories(parentId: parentId);

      emit(CategoryState(
        status: CategoryStatus.success,
        categories: categories,
      ));
    } catch (err) {
      emit(CategoryState(status: CategoryStatus.failure));
    }
  }
}
