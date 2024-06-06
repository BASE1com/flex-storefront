import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/cart/cubits/cart_page_cubit.dart';
import 'package:flex_storefront/cart/widgets/order_summary.dart';
import 'package:flex_storefront/checkout/cubits/address_selection_cubit.dart';
import 'package:flex_storefront/checkout/cubits/checkout_page_cubit.dart';
import 'package:flex_storefront/checkout/cubits/checkout_page_state.dart';
import 'package:flex_storefront/checkout/cubits/delivery_mode_selection_cubit.dart';
import 'package:flex_storefront/checkout/widgets/address_selection_card.dart';
import 'package:flex_storefront/checkout/widgets/checkout_section.dart';
import 'package:flex_storefront/checkout/widgets/delivery_mode_selection_card.dart';
import 'package:flex_storefront/checkout/widgets/payment_selection_card.dart';
import 'package:flex_storefront/checkout/widgets/summary_card.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
      child: BlocListener<CheckoutPageCubit, CheckoutPageState>(
          listener: (_, state) {
            if (state.status == CheckoutPageStatus.orderPlaced) {
              context.router.replaceNamed('/order-confirmation');
            }
          },
          child: CheckoutView()),
    );
  }
}

class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'termsConditions');

  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartPageCubit cubit) => cubit.state.cart);

    return Scaffold(
      appBar: const FlexAppBar(
        showSearchButton: false,
        showBackArrow: true,
        leadingIcon: LineAwesome.times_solid,
        title: Text('Checkout'),
      ),
      body: BlocBuilder<CheckoutPageCubit, CheckoutPageState>(
          builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(FlexSizes.appPadding),
          children: [
            CheckoutSection(
              title: 'Shipping Address',
              content: BlocProvider<AddressSelectionCubit>(
                create: (_) => AddressSelectionCubit()..loadAddresses(),
                child: AddressSelectionCard(
                  onAdd: () {},
                ),
              ),
              pending: state.status == CheckoutPageStatus.pending,
              invalid: state.status == CheckoutPageStatus.invalid &&
                  state.checkoutInfo?.deliveryAddress == null,
              invalidMessage: 'Please select a shipping address',
            ),
            const SizedBox(height: FlexSizes.spacerItems),
            CheckoutSection(
              title: 'Delivery Mode',
              content: BlocProvider<DeliveryModeSelectionCubit>(
                create: (_) =>
                    DeliveryModeSelectionCubit()..loadDeliveryModes(),
                child: DeliveryModeSelectionCard(),
              ),
              pending: state.status == CheckoutPageStatus.pending,
              invalid: state.status == CheckoutPageStatus.invalid &&
                  state.checkoutInfo?.deliveryMode == null,
              invalidMessage: 'Please select a delivery mode',
            ),
            const SizedBox(height: FlexSizes.spacerItems),
            CheckoutSection(
              title: 'Payment',
              content: PaymentSelectionCard(
                paymentInfo: state.checkoutInfo?.paymentInfo,
                onAdd: () {},
                onChange: () {},
              ),
              pending: state.status == CheckoutPageStatus.pending,
              invalid: state.status == CheckoutPageStatus.invalid &&
                  state.checkoutInfo?.paymentInfo == null,
              invalidMessage: 'Please select a payment method',
            ),
            const SizedBox(height: FlexSizes.spacerSection),
            const CheckoutSection(
              title: 'Summary',
              content: SummaryCard(),
            ),
            const SizedBox(height: FlexSizes.spacerSection),
            FormBuilder(
              key: _formKey,
              child: FormBuilderCheckbox(
                name: 'termsChecked',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.equal(
                  true,
                  errorText: 'Please accept the Terms & Conditions',
                ),
                title: const Text(
                  'I am confirming that I have read and agreed with the Terms & Conditions',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.saveAndValidate();
                context.read<CheckoutPageCubit>().validate();
                context.read<CheckoutPageCubit>().placeOrderIfValid(
                      termsConditionsForm: _formKey.currentState!.value,
                    );
              },
              child: const Text('Place Order'),
            ),
          ],
        );
      }),
    );
  }
}
