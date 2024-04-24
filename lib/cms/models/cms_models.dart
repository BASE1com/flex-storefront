import 'package:flex_storefront/shared/models/strapi_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cms_models.g.dart';

class CmsData {
  final int id;

  CmsData({required this.id});
}

@JsonSerializable(createToJson: false, explicitToJson: true)
class CarouselData extends CmsData {
  final List<CarouselDataItem> items;

  CarouselData({required super.id, this.items = const []});

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
