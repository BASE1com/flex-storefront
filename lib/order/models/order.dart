import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/checkout/models/delivery_mode.dart';
import 'package:flex_storefront/checkout/models/payment_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(createToJson: false)
class Order {
  final String code;
  final String statusDisplay;
  final DateTime created;
  final Address deliveryAddress;
  final DeliveryMode deliveryMode;
  final PaymentInfo paymentInfo;

  Order({
    required this.code,
    required this.statusDisplay,
    required this.created,
    required this.deliveryAddress,
    required this.deliveryMode,
    required this.paymentInfo,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  String toString() {
    return 'Order{code: $code, statusDisplay: $statusDisplay, created: $created, deliveryAddress: $deliveryAddress, deliveryMode: $deliveryMode, paymentInfo: $paymentInfo}';
  }
}

@JsonSerializable(createToJson: false)
class OrderSummary {
  final String code;
  final String guid;
  final String statusDisplay;
  final DateTime placed;
  final String status; // TODO: turn into an enum
  final CartPrice total;

  OrderSummary({
    required this.code,
    required this.guid,
    required this.statusDisplay,
    required this.placed,
    required this.status,
    required this.total,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryFromJson(json);

  @override
  String toString() {
    return 'OrderSummary{code: $code, '
        'statusDisplay: $statusDisplay, status: $status'
        'placed: $placed, total: $total}';
  }
}
