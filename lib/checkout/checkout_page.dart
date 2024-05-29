import 'package:auto_route/annotations.dart';
import 'package:flex_storefront/checkout/widgets/checkout_footer.dart';
import 'package:flex_storefront/checkout/widgets/checkout_section.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CheckoutView();
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
                  content: Container(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: FlexSizes.spacerItems),
                CheckoutSection(
                  title: 'Delivery Mode',
                  content: Container(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: FlexSizes.spacerItems),
                CheckoutSection(
                  title: 'Payment',
                  content: Container(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: FlexSizes.spacerItems),
                CheckoutSection(
                  title: 'Order Summary',
                  content: Container(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                  ),
                )
              ],
            ),
          ),
          const CheckoutFooter(),
        ],
      ),
    );
  }
}
