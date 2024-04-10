import 'package:auto_route/annotations.dart';
import 'package:flex_storefront/cart/cubits/cart_cubit.dart';
import 'package:flex_storefront/cart/cubits/cart_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

const webCheckout = true;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.success:
              return Center(
                child: Text(
                    'Total price of your cart: ${state.totalPrice?.formattedValue ?? '\$0.00'}'),
              );
            case Status.failure:
              return const Center(
                child: Text('Failed to load cart'),
              );
            default:
              return const Center(
                child: Text('An unknown error occurred'),
              );
          }
        },
      ),
    );
  }
}
