import 'package:bloc/bloc.dart';
import 'package:flex_storefront/category/apis/category_api.dart';
import 'package:flex_storefront/category/cubits/category_intermediary_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CategoryIntermediaryCubit extends Cubit<CategoryIntermediaryState> {
  final CategoryApi categoryApi = CategoryApi();

  CategoryIntermediaryCubit()
      : super(CategoryIntermediaryState(status: Status.pending));

  Future<void> loadCategory({required int categoryId}) async {
    try {
      emit(CategoryIntermediaryState(status: Status.pending));

      final category = await categoryApi.fetchCategory(
        categoryId: categoryId,
      );

      emit(CategoryIntermediaryState(
        status: Status.success,
        category: category,
      ));
    } catch (err) {
      emit(CategoryIntermediaryState(status: Status.failure));
    }
  }
}
