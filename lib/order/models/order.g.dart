// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      code: json['code'] as String,
      statusDisplay: json['statusDisplay'] as String,
      created: DateTime.parse(json['created'] as String),
      deliveryAddress:
          Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      deliveryMode:
          DeliveryMode.fromJson(json['deliveryMode'] as Map<String, dynamic>),
      paymentInfo:
          PaymentInfo.fromJson(json['paymentInfo'] as Map<String, dynamic>),
    );

OrderSummary _$OrderSummaryFromJson(Map<String, dynamic> json) => OrderSummary(
      code: json['code'] as String,
      guid: json['guid'] as String,
      statusDisplay: json['statusDisplay'] as String,
      placed: DateTime.parse(json['placed'] as String),
      status: json['status'] as String,
      total: CartPrice.fromJson(json['total'] as Map<String, dynamic>),
    );
