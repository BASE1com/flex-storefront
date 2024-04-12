import 'package:flex_storefront/cart/cubits/cart_cubit.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/flex_ui/widgets/quantity_selector.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartEntryActions extends StatelessWidget {
  const CartEntryActions({
    super.key,
    required this.entry,
    required this.quantity,
  });

  final CartItem entry;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final cartLoading = context
        .select((CartCubit cubit) => cubit.state.status == Status.pending);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuantitySelector(
          disabled: cartLoading,
          quantity: quantity,
          onChanged: (val) {
            // todo: update quantity via bloc
          },
        ),
        TextButton(
          onPressed: cartLoading
              ? null
              : () {
                  // tood: implement save for later
                },
          child: const Text('Save for later'),
        ),
        TextButton(
          onPressed: cartLoading
              ? null
              : () {
                  // tood: remove entry via bloc
                },
          child: const Text('Remove'),
        )
      ],
    );
  }
}