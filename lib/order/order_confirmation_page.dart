import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/utils/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderConfirmationView();
  }
}

class OrderConfirmationView extends StatelessWidget {
  const OrderConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlexAppBar(
        showSearchButton: false,
        showBackArrow: true,
        leadingIcon: LineAwesome.times_solid,
        title: Text('Order Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(FlexSizes.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(
              height: MediaQuery.of(context).size.height * 0.33,
              FlexImages.animationOrderSuccess,
              frameRate: FrameRate.max,
            ),
            Text(
              'Order placed successfully!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: FlexSizes.spacerItems),
            Text(
              'Thanks for your order, you will receive an email confirmation shortly.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: FlexSizes.spacerSection),
            ElevatedButton(
              onPressed: () => context.router.maybePop(),
              child: const Text('Continue Shopping'),
            )
          ],
        ),
      ),
    );
  }
}
