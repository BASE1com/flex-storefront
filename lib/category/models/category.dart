import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(createToJson: false)
class Category {
  final int id;
  final String name;
  final CategoryImage? image;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    this.image,
    this.children = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image, children: ${children.length}}';
  }
}

@JsonSerializable(createToJson: false)
class CategoryImage {
  final int id;
  final String url;

  /// The file name can help retrieving the different urls for each size.
  final String name;

  CategoryImage({required this.id, required this.url, required this.name});

  factory CategoryImage.fromJson(Map<String, dynamic> json) =>
      _$CategoryImageFromJson(json);

  @override
  String toString() {
    return 'CategoryImage{id: $id, url: $url, name: $name}';
  }
}
