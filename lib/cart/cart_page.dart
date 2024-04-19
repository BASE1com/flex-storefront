import 'package:auto_route/annotations.dart';
import 'package:flex_storefront/cart/cubits/cart_cubit.dart';
import 'package:flex_storefront/cart/cubits/cart_state.dart';
import 'package:flex_storefront/cart/widgets/cart_content.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => CartCubit()..loadCart(),
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount =
        context.select((CartCubit cubit) => cubit.state.cart?.totalItems);

    return Scaffold(
      appBar: FlexAppBar(
        title: Text('Cart ${itemCount != null ? '($itemCount items)' : ''}'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.pending:
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
    );
  }
}
