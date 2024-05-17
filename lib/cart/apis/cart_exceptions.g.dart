// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartException _$CartExceptionFromJson(Map<String, dynamic> json) =>
    CartException(
      message: json['message'] as String,
      reason: $enumDecode(_$CartExceptionReasonEnumMap, json['reason']),
      subject: json['subject'] as String,
      subjectType: json['subjectType'] as String,
      type: json['type'] as String,
    );

const _$CartExceptionReasonEnumMap = {
  CartExceptionReason.notFound: 'notFound',
};
