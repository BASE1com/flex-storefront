import 'package:auto_route/annotations.dart';
import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/checkout/cubits/address_selection_cubit.dart';
import 'package:flex_storefront/checkout/cubits/checkout_page_cubit.dart';
import 'package:flex_storefront/checkout/cubits/checkout_page_state.dart';
import 'package:flex_storefront/checkout/cubits/delivery_mode_selection_cubit.dart';
import 'package:flex_storefront/checkout/widgets/address_selection_card.dart';
import 'package:flex_storefront/checkout/widgets/checkout_footer.dart';
import 'package:flex_storefront/checkout/widgets/checkout_section.dart';
import 'package:flex_storefront/checkout/widgets/delivery_mode_selection_card.dart';
import 'package:flex_storefront/checkout/widgets/payment_selection_card.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutPageCubit>(
          create: (_) => CheckoutPageCubit()..loadCheckoutInfo(),
        ),
        BlocProvider<CartPageCubit>(
          create: (_) => CartPageCubit(),
        ),
      ],
      child: const CheckoutView(),
    );
  }
}

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlexAppBar(
        showSearchButton: false,
        showBackArrow: true,
        leadingIcon: LineAwesome.times_solid,
        title: Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: FlexSizes.md),
              children: [
                CheckoutSection(
                  title: 'Shipping Address',
                  content: BlocBuilder<CheckoutPageCubit, CheckoutPageState>(
                      builder: (context, state) {
                    switch (state.status) {
                      case Status.success:
                        return BlocProvider<AddressSelectionCubit>(
                          create: (_) =>
                              AddressSelectionCubit()..loadAddresses(),
                          child: AddressSelectionCard(
                            onAdd: () {},
                          ),
                        );
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  }),
                ),
                const SizedBox(height: FlexSizes.spacerItems),
                CheckoutSection(
                  title: 'Delivery Mode',
                  content: BlocBuilder<CheckoutPageCubit, CheckoutPageState>(
                      builder: (context, state) {
                    switch (state.status) {
                      case Status.success:
                        return BlocProvider<DeliveryModeSelectionCubit>(
                          create: (_) =>
                              DeliveryModeSelectionCubit()..loadDeliveryModes(),
                          child: DeliveryModeSelectionCard(),
                        );
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  }),
                ),
                const SizedBox(height: FlexSizes.spacerItems),
                CheckoutSection(
                  title: 'Payment',
                  content: BlocBuilder<CheckoutPageCubit, CheckoutPageState>(
                      builder: (context, state) {
                    switch (state.status) {
                      case Status.success:
                        return PaymentSelectionCard(
                          paymentInfo: state.checkoutInfo!.paymentInfo,
                          onAdd: () {},
                          onChange: () {},
                        );
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
          const CheckoutFooter(),
        ],
      ),
    );
  }
}
