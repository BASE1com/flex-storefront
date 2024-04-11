import 'package:flex_storefront/product_list/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(createToJson: false)
class Cart {
  final String type;
  final List<dynamic> appliedOrderPromotions;
  final List<dynamic> appliedProductPromotions;
  final List<dynamic> appliedVouchers;
  final String code;
  final int? deliveryItemsQuantity;
  final List<CartItem> entries;
  final String guid;
  final bool net;
  final int? pickupItemsQuantity;
  // final CartDiscount productDiscounts;
  final CartPrice subTotal;
  final CartPrice totalDiscounts;
  final int totalItems;
  final CartPrice totalPrice;
  final CartPrice totalPriceWithTax;
  final CartPrice totalTax;
  final User user;
  final PaymentType? paymentType;
  final List<dynamic> potentialOrderPromotions;
  final List<dynamic> potentialProductPromotions;
  final int totalUnitCount;

  Cart({
    required this.type,
    this.appliedOrderPromotions = const [],
    this.appliedProductPromotions = const [],
    this.appliedVouchers = const [],
    required this.code,
    this.deliveryItemsQuantity,
    this.entries = const [],
    required this.guid,
    this.net = false,
    this.pickupItemsQuantity,
    // required this.productDiscounts,
    required this.subTotal,
    required this.totalDiscounts,
    required this.totalItems,
    required this.totalPrice,
    required this.totalPriceWithTax,
    required this.totalTax,
    required this.user,
    this.paymentType,
    this.potentialOrderPromotions = const [],
    this.potentialProductPromotions = const [],
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
  final int? cancellableQuantity;
  final List<dynamic> configurationInfos;
  final int entryNumber;
  final Product product;
  final int quantity;
  final int returnableQuantity;
  final List<dynamic> statusSummaryList;
  final CartPrice totalPrice;
  final bool updateable;

  CartItem({
    required this.basePrice,
    this.cancellableQuantity = 0,
    this.configurationInfos = const [],
    required this.entryNumber,
    required this.product,
    required this.quantity,
    this.returnableQuantity = 0,
    this.statusSummaryList = const [],
    required this.totalPrice,
    this.updateable = true,
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
class Stock {
  final bool isValueRounded;
  final int stockLevel;
  final String stockLevelStatus;

  Stock({
    required this.isValueRounded,
    required this.stockLevel,
    required this.stockLevelStatus,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);
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
