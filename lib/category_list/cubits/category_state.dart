import 'package:flex_storefront/category_list/models/category.dart';

enum CategoryStatus {
  pending,
  success,
  failure,
}

class CategoryState {
  final CategoryStatus status;
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
