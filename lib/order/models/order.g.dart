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
