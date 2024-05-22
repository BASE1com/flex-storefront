import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FlexSizes.appPadding),
      child: Column(
        children: [
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: FlexSizes.xs),
          Text(
            'Sign in to access your account.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
