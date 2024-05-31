// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutInfo _$CheckoutInfoFromJson(Map<String, dynamic> json) => CheckoutInfo(
      deliveryAddress: json['deliveryAddress'] == null
          ? null
          : Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutInfoToJson(CheckoutInfo instance) =>
    <String, dynamic>{
      'deliveryAddress': instance.deliveryAddress?.toJson(),
    };
