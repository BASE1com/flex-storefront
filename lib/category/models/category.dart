import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(createToJson: false)
class Category {
  final int id;
  final String name;
  final CategoryImage? image;

  Category({
    required this.id,
    required this.name,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image}';
  }
}

@JsonSerializable(createToJson: false)
class CategoryImage {
  final String url;

  CategoryImage({required this.url});

  factory CategoryImage.fromJson(Map<String, dynamic> json) =>
      _$CategoryImageFromJson(json);

  @override
  String toString() {
    return 'CategoryImage{url: $url}';
  }
}
