import 'package:flex_storefront/product_list/models/price.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_mode.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: true)
class DeliveryMode {
  final String code;
  final String name;
  final String? description;
  final Price? price;

  DeliveryMode({
    required this.code,
    required this.name,
    required this.description,
    this.price,
  });

  factory DeliveryMode.fromJson(Map<String, dynamic> json) =>
      _$DeliveryModeFromJson(json);

  @override
  String toString() {
    return 'DeliveryMode{code: $code, name: $name, description: $description, price: $price}';
  }
}
