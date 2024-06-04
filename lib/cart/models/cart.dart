import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

/// User descriptor used when requesting any cart endpoint
enum UserType {
  anonymous,
  current,
}

@JsonSerializable(createToJson: false)
class Cart {
  final String type;
  @visibleForTesting
  final String? code;
  final List<CartItem> entries;
  @visibleForTesting
  final String? guid;
  final bool net;
  final CartPrice subTotal;
  final CartPrice totalDiscounts;
  final int totalItems;
  // TODO Move the price breakdown in CheckoutInfo rather than Cart
  final CartPrice totalPrice;
  final CartPrice totalPriceWithTax;
  final CartPrice totalTax;
  final CartPrice? deliveryCost;
  final int totalUnitCount;

  Cart({
    required this.type,
    this.code,
    this.entries = const [],
    this.guid,
    this.net = false,
    required this.subTotal,
    required this.totalDiscounts,
    required this.totalItems,
    required this.totalPrice,
    required this.totalPriceWithTax,
    required this.totalTax,
    this.deliveryCost,
    required this.totalUnitCount,
  }) : assert((code != null) ^ (guid != null)); // <--- XOR operator

  factory Cart.fromJson(UserType userType, Map<String, dynamic> json) {
    // The `code` is meaningful on user's cart whereas the `guid` is meaningful
    // on anonymous cart.
    // To abstract this Hybris particularity, we delete the non-relevant
    // property, so then we can safely determine whether it's a anonymous or
    // user cart by looking at the properties (see the `identifier` and
    // `userType` getter)
    if (userType == UserType.anonymous) {
      json.remove('code');
    } else if (userType == UserType.current) {
      json.remove('guid');
    }

    return _$CartFromJson(json);
  }

  String get identifier => code ?? guid!;

  UserType get userType => code != null ? UserType.current : UserType.anonymous;

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
