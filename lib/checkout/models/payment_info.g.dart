// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => PaymentInfo(
      id: json['id'] as String,
      accountHolderName: json['accountHolderName'] as String,
      billingAddress:
          Address.fromJson(json['billingAddress'] as Map<String, dynamic>),
      cardNumber: json['cardNumber'] as String,
      cardType: CardType.fromJson(json['cardType'] as Map<String, dynamic>),
      expiryMonth: json['expiryMonth'] as String,
      expiryYear: json['expiryYear'] as String,
    );

CardType _$CardTypeFromJson(Map<String, dynamic> json) => CardType(
      code: json['code'] as String,
      name: json['name'] as String,
    );
