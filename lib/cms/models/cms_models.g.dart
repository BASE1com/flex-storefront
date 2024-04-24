// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselData _$CarouselDataFromJson(Map<String, dynamic> json) => CarouselData(
      id: json['id'] as int,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CarouselDataItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

CarouselDataItem _$CarouselDataItemFromJson(Map<String, dynamic> json) =>
    CarouselDataItem(
      id: json['id'] as int,
      link: json['link'] as String,
      media: StrapiImage.fromJson(json['media'] as Map<String, dynamic>),
    );
