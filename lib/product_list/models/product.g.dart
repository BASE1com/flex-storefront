// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      code: json['code'] as String,
      name: json['name'] as String,
      url: json['url'] as String?,
      description: json['description'] as String?,
      purchasable: json['purchasable'] as bool? ?? true,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      numberOfReviews: json['numberOfReviews'] as int?,
      summary: json['summary'] as String?,
      manufacturer: json['manufacturer'] as String?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      baseProduct: json['baseProduct'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
