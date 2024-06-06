import 'package:flex_storefront/checkout/models/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_info.g.dart';

@JsonSerializable(createToJson: false)
class PaymentInfo {
  final String id;
  final String accountHolderName;
  final Address billingAddress;
  final String cardNumber;
  final CardType cardType;
  final String expiryMonth;
  final String expiryYear;

  PaymentInfo({
    required this.id,
    required this.accountHolderName,
    required this.billingAddress,
    required this.cardNumber,
    required this.cardType,
    required this.expiryMonth,
    required this.expiryYear,
  });

  String get multiLineDisplay {
    return '''$accountHolderName
$cardNumber
Expires: ${expiryMonth.padLeft(2, '0')}/${expiryYear}''';
  }

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);

  @override
  String toString() {
    return 'PaymentInfo{id: $id, accountHolderName: $accountHolderName, billingAddress: $billingAddress, cardType: $cardType, expiryMonth: $expiryMonth, expiryYear: $expiryYear}';
  }
}

@JsonSerializable(createToJson: false)
class CardType {
  final String code;
  final String name;

  CardType({
    required this.code,
    required this.name,
  });

  factory CardType.fromJson(Map<String, dynamic> json) =>
      _$CardTypeFromJson(json);

  @override
  String toString() {
    return 'CardType{code: $code, name: $name}';
  }
}
