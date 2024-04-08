import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CategoryIntermediaryState {
  final Status status;
  final Category? category;

  CategoryIntermediaryState({
    required this.status,
    this.category,
  });

  @override
  String toString() {
    return 'CategoryIntermediaryState{status: $status, category: $category}';
  }
}
