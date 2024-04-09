import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(createToJson: false)
class Image {
  final String imageType;
  final String format;
  final String url;
  final String? altText;

  Image({
    required this.imageType,
    required this.format,
    required this.url,
    this.altText,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  @override
  String toString() {
    return 'Image{imageType: $imageType, format: $format, url: $url, altText: $altText}';
  }
}
