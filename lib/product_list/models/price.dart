import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable(createToJson: false)
class Price {
  final String currencyIso;
  final double value;
  final String priceType;
  final String formattedValue;

  Price({
    required this.currencyIso,
    required this.value,
    required this.priceType,
    required this.formattedValue,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  @override
  String toString() {
    return 'Price{formattedValue: $formattedValue, value: $value}';
  }
}
