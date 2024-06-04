import 'package:flex_storefront/checkout/models/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkout_info.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutInfo {
  final Address? deliveryAddress;

  CheckoutInfo({
    this.deliveryAddress,
  });

  factory CheckoutInfo.fromJson(Map<String, dynamic> json) =>
      _$CheckoutInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutInfoToJson(this);

  @override
  String toString() {
    return 'CheckoutInfo{deliveryAddress: $deliveryAddress}';
  }
}
