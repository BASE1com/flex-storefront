import 'package:flex_storefront/product_list/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(createToJson: false)
class Cart {
  final String type;
  final String code;
  final List<CartItem> entries;
  final String guid;
  final bool net;
  final CartPrice subTotal;
  final CartPrice totalDiscounts;
  final int totalItems;
  final CartPrice totalPrice;
  final CartPrice totalPriceWithTax;
  final CartPrice totalTax;
  final User user;
  final PaymentType? paymentType;
  final int totalUnitCount;

  Cart({
    required this.type,
    required this.code,
    this.entries = const [],
    required this.guid,
    this.net = false,
    required this.subTotal,
    required this.totalDiscounts,
    required this.totalItems,
    required this.totalPrice,
    required this.totalPriceWithTax,
    required this.totalTax,
    required this.user,
    this.paymentType,
    required this.totalUnitCount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  @override
  String toString() {
    return 'Cart{code: $code, totalItems: $totalItems, totalPrice: $totalPrice}';
  }
}

@JsonSerializable(createToJson: false)
class CartItem {
  final CartPrice basePrice;
  final int entryNumber;
  final Product product;
  final int quantity;
  final CartPrice totalPrice;

  CartItem({
    required this.basePrice,
    required this.entryNumber,
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@JsonSerializable()
class CartPrice {
  final String? currencyIso;
  final String formattedValue;
  final String? priceType;
  final double value;

  CartPrice({
    this.currencyIso,
    required this.formattedValue,
    this.priceType,
    required this.value,
  });

  factory CartPrice.fromJson(Map<String, dynamic> json) =>
      _$CartPriceFromJson(json);

  Map<String, dynamic> toJson() => _$CartPriceToJson(this);
}

@JsonSerializable()
class User {
  final String name;
  final String uid;

  User({
    required this.name,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class PaymentType {
  final String code;
  final String displayName;

  PaymentType({
    required this.code,
    required this.displayName,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTypeToJson(this);
}
