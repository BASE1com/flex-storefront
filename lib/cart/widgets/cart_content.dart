import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/cart/widgets/cart_item_entry.dart';
import 'package:flex_storefront/cart/widgets/order_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CartContent extends StatelessWidget {
  const CartContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartPageCubit cubit) => cubit.state.cart)!;

    final widgets = [
      ...cart.entries.map((entry) {
        return CartItemEntry(
          entry: entry,
        );
      }),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OrderSummary(cart: cart),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.router.pushNamed('/login'),
            child: const Text('Proceed to Checkout'),
          ),
        ],
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widgets.length,
      itemBuilder: (_, index) => widgets[index],
      separatorBuilder: (_, __) => const Divider(height: 24),
    );
  }
}
