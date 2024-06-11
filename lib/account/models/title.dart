import 'package:json_annotation/json_annotation.dart';

part 'title.g.dart';

@JsonSerializable(explicitToJson: true)
class Title {
  final String code;
  final String name;

  const Title({
    required this.code,
    required this.name,
  });

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);

  Map<String, dynamic> toJson() => _$TitleToJson(this);

  @override
  String toString() {
    return 'Title{code: $code, name: $name}';
  }
}
