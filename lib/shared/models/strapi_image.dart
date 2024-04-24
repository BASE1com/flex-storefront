import 'package:json_annotation/json_annotation.dart';

part 'strapi_image.g.dart';

@JsonSerializable(createToJson: false)
class StrapiImage {
  final int id;
  final String url;

  /// The file name can help retrieving the different urls for each size.
  final String name;

  StrapiImage({required this.id, required this.url, required this.name});

  factory StrapiImage.fromJson(Map<String, dynamic> json) =>
      _$StrapiImageFromJson(json);

  @override
  String toString() {
    return 'StrapiImage{id: $id, url: $url, name: $name}';
  }
}
