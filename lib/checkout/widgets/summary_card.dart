import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/cart/cubits/cart_page_state.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageCubit, CartPageState>(builder: (context, state) {
      return RoundedCard(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Discounts:'),
                Text(state.cart?.totalDiscounts.formattedValue ?? ''),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal after discounts:'),
                Text(state.cart?.subTotal.formattedValue ?? ''),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping:'),
                Text(state.cart?.deliveryCost?.formattedValue ?? ''),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Taxes:'),
                Text(state.cart?.totalTax.formattedValue ?? ''),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Total'),
                Text(state.cart?.totalPriceWithTax.formattedValue ?? ''),
              ],
            ),
          ],
        ),
      );
    });
  }
}
