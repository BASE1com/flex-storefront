import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/cart/cubits/cart_page_state.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutFooter extends StatelessWidget {
  const CheckoutFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            spreadRadius: 0.0,
            color: Colors.grey.shade400,
          ),
        ],
        color: Colors.white,
      ),
      child: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(FlexSizes.md),
          child: BlocBuilder<CartPageCubit, CartPageState>(
              builder: (context, state) {
            return Column(
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
                const SizedBox(height: FlexSizes.spacerItems),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Place Order'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
