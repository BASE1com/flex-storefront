// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] == null
          ? null
          : CategoryImage.fromJson(json['image'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

CategoryImage _$CategoryImageFromJson(Map<String, dynamic> json) =>
    CategoryImage(
      id: json['id'] as int,
      url: json['url'] as String,
      name: json['name'] as String,
    );
