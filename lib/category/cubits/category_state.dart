import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CategoryState extends BlocState {
  final List<Category> categories;

  CategoryState({
    required super.status,
    super.error,
    super.stackTrace,
    this.categories = const [],
  });

  @override
  String toString() {
    return 'CategoryState{status: $status, categories: ${categories.length}}';
  }
}
