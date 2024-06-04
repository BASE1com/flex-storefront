import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/checkout/models/delivery_mode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkout_info.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class CheckoutInfo {
  final Address? deliveryAddress;
  final DeliveryMode? deliveryMode;

  CheckoutInfo({
    this.deliveryAddress,
    this.deliveryMode,
  });

  factory CheckoutInfo.fromJson(Map<String, dynamic> json) =>
      _$CheckoutInfoFromJson(json);

  @override
  String toString() {
    return 'CheckoutInfo{deliveryAddress: $deliveryAddress, deliveryMode: $deliveryMode}';
  }
}
