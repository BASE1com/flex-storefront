// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      type: json['type'] as String,
      code: json['code'] as String?,
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      guid: json['guid'] as String?,
      net: json['net'] as bool? ?? false,
      subTotal: CartPrice.fromJson(json['subTotal'] as Map<String, dynamic>),
      totalDiscounts:
          CartPrice.fromJson(json['totalDiscounts'] as Map<String, dynamic>),
      totalItems: json['totalItems'] as int,
      totalPrice:
          CartPrice.fromJson(json['totalPrice'] as Map<String, dynamic>),
      totalPriceWithTax:
          CartPrice.fromJson(json['totalPriceWithTax'] as Map<String, dynamic>),
      totalTax: CartPrice.fromJson(json['totalTax'] as Map<String, dynamic>),
      deliveryCost: json['deliveryCost'] == null
          ? null
          : CartPrice.fromJson(json['deliveryCost'] as Map<String, dynamic>),
      totalUnitCount: json['totalUnitCount'] as int,
    );

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      basePrice: CartPrice.fromJson(json['basePrice'] as Map<String, dynamic>),
      entryNumber: json['entryNumber'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      totalPrice:
          CartPrice.fromJson(json['totalPrice'] as Map<String, dynamic>),
    );

CartPrice _$CartPriceFromJson(Map<String, dynamic> json) => CartPrice(
      currencyIso: json['currencyIso'] as String?,
      formattedValue: json['formattedValue'] as String,
      priceType: json['priceType'] as String?,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$CartPriceToJson(CartPrice instance) => <String, dynamic>{
      'currencyIso': instance.currencyIso,
      'formattedValue': instance.formattedValue,
      'priceType': instance.priceType,
      'value': instance.value,
    };

PaymentType _$PaymentTypeFromJson(Map<String, dynamic> json) => PaymentType(
      code: json['code'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$PaymentTypeToJson(PaymentType instance) =>
    <String, dynamic>{
      'code': instance.code,
      'displayName': instance.displayName,
    };
