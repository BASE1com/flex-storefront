// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMode _$DeliveryModeFromJson(Map<String, dynamic> json) => DeliveryMode(
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
    );
