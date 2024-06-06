import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/cart/widgets/cart_item_entry.dart';
import 'package:flex_storefront/cart/widgets/order_summary.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
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
      RoundedCard(child: OrderSummary(cart: cart)),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(FlexSizes.appPadding),
      itemCount: widgets.length,
      itemBuilder: (_, index) => widgets[index],
      separatorBuilder: (_, index) => index == widgets.length - 2
          ? const SizedBox(height: FlexSizes.lg)
          : const Divider(height: FlexSizes.lg),
    );
  }
}
