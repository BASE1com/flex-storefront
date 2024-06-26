import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/ecommerce/product_list_item.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
import 'package:flex_storefront/order/cubits/orders_list_cubit.dart';
import 'package:flex_storefront/order/cubits/orders_list_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersListCubit()..loadOrders(),
      child: const Scaffold(
        appBar: FlexAppBar(
          title: Text('My Orders'),
          showBackArrow: true,
          showSearchButton: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(FlexSizes.appPadding),
          child: OrdersListView(),
        ),
      ),
    );
  }
}

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersListCubit, OrdersListState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial || Status.pending:
            return const Column(
              children: [
                ProductListItemShimmer(),
                ProductListItemShimmer(),
                ProductListItemShimmer(),
              ],
            );
          case Status.success:
            return ListView.separated(
              itemCount: state.orders.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: FlexSizes.spacerItems),
              itemBuilder: (_, index) {
                final order = state.orders[index];

                return RoundedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(LineAwesome.shipping_fast_solid),
                          const SizedBox(width: FlexSizes.spacerItems),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.statusDisplay.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: FlexColors.success,
                                        fontWeightDelta: 2,
                                      ),
                                ),
                                Text(order.placed.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: FlexSizes.spacerItems),
                      Text('Order #: ${order.code}'),
                      Text('Order Total: ${order.total.formattedValue}'),
                    ],
                  ),
                );
              },
            );
          case Status.failure:
            return const Center(child: Text('Failed to load orders'));
        }
      },
    );
  }
}
