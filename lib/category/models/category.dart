import 'package:flex_storefront/shared/models/strapi_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(createToJson: false)
class Category {
  final int id;
  final String code;
  final String name;
  final String? destination;
  final StrapiImage? image;
  final List<Category> children;

  Category({
    required this.id,
    required this.code,
    required this.name,
    this.destination,
    this.image,
    this.children = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  String toString() {
    return 'Category{id: $id, code: $code, name: $name, destination: $destination, image: $image, children: ${children.length}}';
  }
}
