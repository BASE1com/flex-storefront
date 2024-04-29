import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/models/strapi_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cms_models.g.dart';

class CmsData {
  final int id;

  CmsData({required this.id});
}

@JsonSerializable(createToJson: false)
class SpacerData extends CmsData {
  @SpaceValueConverter()
  final double space;

  SpacerData({
    required super.id,
    required this.space,
  });

  factory SpacerData.fromJson(Map<String, dynamic> json) =>
      _$SpacerDataFromJson(json);

  @override
  String toString() {
    return 'SpacerData{space: $space}';
  }
}

@JsonSerializable(createToJson: false)
class HeaderData extends CmsData {
  final String text;

  HeaderData({
    required super.id,
    required this.text,
  });

  factory HeaderData.fromJson(Map<String, dynamic> json) =>
      _$HeaderDataFromJson(json);

  @override
  String toString() {
    return 'HeaderData{text: $text}';
  }
}

@JsonSerializable(createToJson: false, explicitToJson: true)
class BannerData extends CmsData {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  final String link;
  final StrapiImage banner;

  BannerData({
    required super.id,
    required this.aspectRatio,
    required this.link,
    required this.banner,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) =>
      _$BannerDataFromJson(json);

  @override
  String toString() {
    return 'BannerData{aspectRatio: $aspectRatio, link: $link, banner: $banner}';
  }
}

@JsonSerializable(createToJson: false, explicitToJson: true)
class CarouselData extends CmsData {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  final List<CarouselDataItem> items;

  CarouselData({
    required super.id,
    required this.aspectRatio,
    this.items = const [],
  });

  factory CarouselData.fromJson(Map<String, dynamic> json) =>
      _$CarouselDataFromJson(json);

  @override
  String toString() {
    return 'CarouselData{items: $items}';
  }
}

@JsonSerializable(createToJson: false, explicitToJson: true)
class CarouselDataItem {
  final int id;
  final String link;
  final StrapiImage media;

  CarouselDataItem({
    required this.id,
    required this.link,
    required this.media,
  });

  factory CarouselDataItem.fromJson(Map<String, dynamic> json) =>
      _$CarouselDataItemFromJson(json);

  @override
  String toString() {
    return 'CarouselDataItem{id: $id, link: $link, media: $media}';
  }
}

class SpaceValueConverter extends JsonConverter<double, String> {
  const SpaceValueConverter();

  @override
  double fromJson(String json) {
    // Impossible to do better with static consts (as opposed to enum)
    switch (json) {
      case 'sm':
        return FlexSizes.sm;
      case 'md':
        return FlexSizes.md;
      case 'lg':
        return FlexSizes.lg;
      default:
        throw Exception('Unknown value for space $json');
    }
  }

  @override
  String toJson(double object) {
    throw UnimplementedError();
  }
}
