// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartException _$CartExceptionFromJson(Map<String, dynamic> json) =>
    CartException(
      type: json['type'] as String,
      message: json['message'] as String,
      reason: $enumDecodeNullable(_$CartExceptionReasonEnumMap, json['reason']),
      subject: json['subject'] as String?,
      subjectType: json['subjectType'] as String?,
    );

const _$CartExceptionReasonEnumMap = {
  CartExceptionReason.notFound: 'notFound',
};
