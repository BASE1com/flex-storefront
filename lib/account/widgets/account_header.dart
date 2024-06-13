import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/my_account/cubits/my_account_cubit.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.select((MyAccountCubit cubit) => cubit.state.user);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FlexSizes.appPadding,
        vertical: FlexSizes.sm,
      ),
      child: Column(
        children: [
          Text(
            'Welcome,',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: FlexSizes.xs),
          Text(
            user?.name ?? 'Sign in to access your account.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (user != null) ...[
            Text(
              user.uid,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextButton(
              onPressed: () => context.router.pushNamed('edit'),
              child: const Text('Edit my account'),
            ),
          ],
          if (user == null) ...[
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
        ],
      ),
    );
  }
}
