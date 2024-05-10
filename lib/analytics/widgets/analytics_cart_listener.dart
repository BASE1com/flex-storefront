import 'dart:async';

import 'package:flex_storefront/analytics/apis/analytics_api.dart';
import 'package:flex_storefront/analytics/models/analytics_events.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AnalyticsCartListener extends StatefulWidget {
  final Widget child;

  const AnalyticsCartListener({
    super.key,
    required this.child,
  });

  @override
  State<AnalyticsCartListener> createState() => _AnalyticsCartListenerState();
}

class _AnalyticsCartListenerState extends State<AnalyticsCartListener> {
  late final StreamSubscription<CartMessage> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = GetIt.instance
        .get<CartRepository>()
        .getCartMessageStream()
        .listen(_onMessage);
  }

  void _onMessage(CartMessage message) {
    if (message is AddToCartMessage) {
      GetIt.instance.get<AnalyticsApi>().track(
            AddToCartEvent.fromData(
              message.product,
              message.quantityAdded,
            ),
          );
    } else if (message is RemoveFromCartMessage) {
      GetIt.instance.get<AnalyticsApi>().track(
            RemoveFromCartEvent.fromProduct(
              message.product,
            ),
          );
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
