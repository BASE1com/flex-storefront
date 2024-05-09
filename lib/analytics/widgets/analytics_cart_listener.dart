import 'dart:async';

import 'package:flex_storefront/analytics/apis/analytics_api.dart';
import 'package:flex_storefront/analytics/models/analytics_events.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CartMessageListener extends StatefulWidget {
  final Widget child;

  const CartMessageListener({
    super.key,
    required this.child,
  });

  @override
  State<CartMessageListener> createState() => _CartMessageListenerState();
}

class _CartMessageListenerState extends State<CartMessageListener> {
  late final StreamSubscription<CartMessage> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = GetIt.instance
        .get<CartRepository>()
        .getCartMessageStream()
        .listen(_onMessage);
  }

  void _onMessage(CartMessage event) {
    if (event is ChangeQuantityMessage) {
      if (event.quantityDiff >= 0) {
        GetIt.instance.get<AnalyticsApi>().track(
              AddToCartEvent.fromData(
                event.product,
                event.quantityDiff,
              ),
            );
      } else {
        GetIt.instance.get<AnalyticsApi>().track(
              RemoveFromCartEvent.fromData(
                event.product,
                -event.quantityDiff,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
