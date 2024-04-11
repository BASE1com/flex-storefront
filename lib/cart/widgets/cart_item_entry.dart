import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/cart/widgets/cart_entry_actions.dart';
import 'package:flex_storefront/cart/widgets/cart_entry_product.dart';
import 'package:flutter/material.dart';

class CartItemEntry extends StatelessWidget {
  const CartItemEntry({
    super.key,
    required this.entry,
    this.showActions = true,
  });

  final CartItem entry;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    final quantity = entry.quantity;

    return Column(
      children: [
        CartEntryProduct(
          entry: entry,
        ),
        const SizedBox(height: 16),
        if (showActions)
          CartEntryActions(
            quantity: quantity,
            entry: entry,
          ),
      ],
    );
  }
}
