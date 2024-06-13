import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FlexSizes.appPadding,
        vertical: FlexSizes.sm,
      ),
      child: user.isAnonymous
          ? Column(
              children: [
                Text(
                  'Welcome,',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: FlexSizes.xs),
                Text(
                  'Sign in to access your account.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: FlexSizes.sm),
                ElevatedButton(
                  onPressed: () {
                    context.router.navigate(LoginRoute(
                      onLoginAttempt: (success) {
                        if (success) {
                          context.router.maybePop();
                        }
                      },
                    ));
                  },
                  child: const Text('Sign In'),
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  'Welcome,',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: FlexSizes.xs),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  user.uid,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: () => context.router.pushNamed('edit'),
                  child: const Text('Edit my account'),
                ),
              ],
            ),
    );
  }
}
