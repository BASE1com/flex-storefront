import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CategoryIntermediaryState extends BlocState {
  final Category? category;

  CategoryIntermediaryState({
    required super.status,
    super.error,
    super.stackTrace,
    this.category,
  });

  @override
  String toString() {
    return 'CategoryIntermediaryState{status: $status, category: $category}';
  }
}
