// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      type: json['type'] as String,
      appliedOrderPromotions:
          json['appliedOrderPromotions'] as List<dynamic>? ?? const [],
      appliedProductPromotions:
          json['appliedProductPromotions'] as List<dynamic>? ?? const [],
      appliedVouchers: json['appliedVouchers'] as List<dynamic>? ?? const [],
      code: json['code'] as String,
      deliveryItemsQuantity: json['deliveryItemsQuantity'] as int?,
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      guid: json['guid'] as String,
      net: json['net'] as bool? ?? false,
      pickupItemsQuantity: json['pickupItemsQuantity'] as int?,
      subTotal: CartPrice.fromJson(json['subTotal'] as Map<String, dynamic>),
      totalDiscounts:
          CartPrice.fromJson(json['totalDiscounts'] as Map<String, dynamic>),
      totalItems: json['totalItems'] as int,
      totalPrice:
          CartPrice.fromJson(json['totalPrice'] as Map<String, dynamic>),
      totalPriceWithTax:
          CartPrice.fromJson(json['totalPriceWithTax'] as Map<String, dynamic>),
      totalTax: CartPrice.fromJson(json['totalTax'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      paymentType: json['paymentType'] == null
          ? null
          : PaymentType.fromJson(json['paymentType'] as Map<String, dynamic>),
      potentialOrderPromotions:
          json['potentialOrderPromotions'] as List<dynamic>? ?? const [],
      potentialProductPromotions:
          json['potentialProductPromotions'] as List<dynamic>? ?? const [],
      totalUnitCount: json['totalUnitCount'] as int,
    );

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      basePrice: CartPrice.fromJson(json['basePrice'] as Map<String, dynamic>),
      cancellableQuantity: json['cancellableQuantity'] as int? ?? 0,
      configurationInfos:
          json['configurationInfos'] as List<dynamic>? ?? const [],
      entryNumber: json['entryNumber'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      returnableQuantity: json['returnableQuantity'] as int? ?? 0,
      statusSummaryList:
          json['statusSummaryList'] as List<dynamic>? ?? const [],
      totalPrice:
          CartPrice.fromJson(json['totalPrice'] as Map<String, dynamic>),
      updateable: json['updateable'] as bool? ?? true,
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

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      isValueRounded: json['isValueRounded'] as bool,
      stockLevel: json['stockLevel'] as int,
      stockLevelStatus: json['stockLevelStatus'] as String,
    );

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'isValueRounded': instance.isValueRounded,
      'stockLevel': instance.stockLevel,
      'stockLevelStatus': instance.stockLevelStatus,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
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
