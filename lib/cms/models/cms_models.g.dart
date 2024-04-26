// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpacerData _$SpacerDataFromJson(Map<String, dynamic> json) => SpacerData(
      id: json['id'] as int,
      space: const SpaceValueConverter().fromJson(json['space'] as String),
    );

HeaderData _$HeaderDataFromJson(Map<String, dynamic> json) => HeaderData(
      id: json['id'] as int,
      text: json['text'] as String,
    );

BannerData _$BannerDataFromJson(Map<String, dynamic> json) => BannerData(
      id: json['id'] as int,
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      link: json['link'] as String,
      banner: StrapiImage.fromJson(json['banner'] as Map<String, dynamic>),
    );

CarouselData _$CarouselDataFromJson(Map<String, dynamic> json) => CarouselData(
      id: json['id'] as int,
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
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
