import 'package:json_annotation/json_annotation.dart';

part 'cart_exceptions.g.dart';

enum CartExceptionReason {
  notFound,
}

@JsonSerializable(createToJson: false)
class CartException implements Exception {
  final String message;
  final CartExceptionReason reason;
  final String subject;
  final String subjectType;
  final String type;

  const CartException({
    required this.message,
    required this.reason,
    required this.subject,
    required this.subjectType,
    required this.type,
  });

  factory CartException.fromJson(Map<String, dynamic> json) =>
      _$CartExceptionFromJson(json);

  @override
  String toString() =>
      'CartException{message: $message, reason: $reason, subject: $subject, '
      'subjectType: $subjectType, type: $type}';
}
