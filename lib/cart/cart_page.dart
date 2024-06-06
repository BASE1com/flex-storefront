import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/cart/cubits/cart_page_state.dart';
import 'package:flex_storefront/cart/widgets/cart_content.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartPageCubit>(
      create: (context) => CartPageCubit(),
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount =
        context.select((CartPageCubit cubit) => cubit.state.cart?.totalItems);
    final totalPrice = context.select(
        (CartPageCubit cubit) => cubit.state.cart?.totalPrice.formattedValue);

    return Scaffold(
      appBar: FlexAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Cart ${itemCount != null ? '($itemCount items)' : ''}'),
            Text(totalPrice ?? ''),
          ],
        ),
        showSearchButton: false,
      ),
      body: BlocBuilder<CartPageCubit, CartPageState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial || Status.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.success:
              return const CartContent();
            case Status.failure:
              return const Center(
                child: Text('Failed to load cart'),
              );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(FlexSizes.appPadding),
        child: ElevatedButton(
          onPressed: () => context.router.pushNamed('/checkout'),
          child: const Text('Proceed to Checkout'),
        ),
      ),
    );
  }
}
