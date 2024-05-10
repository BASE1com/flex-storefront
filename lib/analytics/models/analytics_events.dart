import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/product_list/models/product.dart';

abstract class AnalyticsEvent {
  final Map<String, Object?>? parameters;

  const AnalyticsEvent({this.parameters});
}

abstract class AnalyticsItemsEvent extends AnalyticsEvent {
  final String? currency;
  final double? value;
  final List<AnalyticsEventItem>? items;

  const AnalyticsItemsEvent({
    this.currency,
    this.value,
    this.items,
    super.parameters,
  });

  @override
  String toString() {
    return '$runtimeType{currency: $currency, value: $value, items: $items}';
  }
}

/// This event signifies that some content was shown to the user.
/// Use this event to discover the most popular items viewed.
class ViewItemEvent extends AnalyticsItemsEvent {
  const ViewItemEvent({
    super.currency,
    super.value,
    super.items,
    super.parameters,
  });

  factory ViewItemEvent.fromProduct(Product product) {
    return ViewItemEvent(
      currency: product.price?.currencyIso,
      value: product.price?.value,
      items: [
        AnalyticsEventItem(
          itemId: product.code,
          itemName: product.name,
          price: product.price?.value,
        )
      ],
    );
  }
}

/// This event signifies that a user has selected some content of a certain type.
/// This event can help you identify popular content and categories of content on your website or app.
class SelectContentEvent extends AnalyticsEvent {
  final String contentType;
  final String itemId;

  const SelectContentEvent({
    required this.contentType,
    required this.itemId,
    super.parameters,
  });

  factory SelectContentEvent.fromCategoryCode(String categoryCode) {
    return SelectContentEvent(
      contentType: 'category',
      itemId: categoryCode,
    );
  }
}

/// This event signifies that a user viewed their cart.
class ViewCartEvent extends AnalyticsItemsEvent {
  const ViewCartEvent({
    super.currency,
    super.value,
    super.items,
    super.parameters,
  });

  factory ViewCartEvent.fromCart(Cart? cart) {
    return ViewCartEvent(
      currency: cart?.totalPrice.currencyIso,
      value: cart?.totalPrice.value,
      items: cart?.entries
          .map((entry) => AnalyticsEventItem(
                itemId: entry.product.code,
                itemName: entry.product.name,
                price: entry.basePrice.value,
                quantity: entry.quantity,
              ))
          .toList(),
    );
  }
}

/// This event signifies that an item was added to a cart.
class AddToCartEvent extends AnalyticsItemsEvent {
  const AddToCartEvent({
    super.currency,
    super.value,
    super.items,
    super.parameters,
  });

  factory AddToCartEvent.fromData(Product product, int quantity) {
    return AddToCartEvent(
      currency: product.price?.currencyIso,
      value: product.price?.value,
      items: [
        AnalyticsEventItem(
          itemId: product.code,
          itemName: product.name,
          price: product.price?.value,
          quantity: quantity,
        )
      ],
    );
  }
}

/// This event signifies that an item was removed from a cart.
class RemoveFromCartEvent extends AnalyticsItemsEvent {
  const RemoveFromCartEvent({
    super.currency,
    super.value,
    super.items,
    super.parameters,
  });

  factory RemoveFromCartEvent.fromProduct(Product product) {
    return RemoveFromCartEvent(
      currency: product.price?.currencyIso,
      value: product.price?.value,
      items: [
        AnalyticsEventItem(
          itemId: product.code,
          itemName: product.name,
          price: product.price?.value,
        )
      ],
    );
  }
}
