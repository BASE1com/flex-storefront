import 'package:collection/collection.dart';
import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/product_list/models/image.dart';
import 'package:flex_storefront/product_list/models/price.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(createToJson: false)
class Product {
  final String code;
  final String name;
  final String? url;
  final String? description;
  final bool purchasable;
  final double? averageRating;
  final int? numberOfReviews;
  final String? summary;
  final String? manufacturer;
  final Price? price;
  final String? baseProduct;
  final List<Image> images;
  final List<ProductCategory> categories;

  Product({
    required this.code,
    required this.name,
    this.url,
    this.description,
    this.purchasable = true,
    this.averageRating,
    this.numberOfReviews,
    this.summary,
    this.manufacturer,
    this.price,
    this.baseProduct,
    this.images = const [],
    this.categories = const [],
  });

  Image? get cartImage =>
      images.firstWhereOrNull((e) => e.format == 'cartIcon') ??
      images.firstOrNull;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  @override
  String toString() {
    return 'Product{code: $code, name: $name, price: $price}';
  }
}

@JsonSerializable(createToJson: false)
class ProductCategory {
  final String code;
  final String name;

  ProductCategory({
    required this.code,
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);
}
