// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      currencyIso: json['currencyIso'] as String,
      value: (json['value'] as num).toDouble(),
      priceType: json['priceType'] as String,
      formattedValue: json['formattedValue'] as String,
    );
