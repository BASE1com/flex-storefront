import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CategoryState {
  final Status status;
  final List<Category> categories;

  CategoryState({
    required this.status,
    this.categories = const [],
  });

  @override
  String toString() {
    return 'CategoryState{status: $status, categories: ${categories.length}}';
  }
}
