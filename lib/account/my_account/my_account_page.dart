import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/my_account/cubits/my_account_cubit.dart';
import 'package:flex_storefront/account/widgets/account_header.dart';
import 'package:flex_storefront/account/widgets/settings_list_tile.dart';
import 'package:flex_storefront/account/widgets/settings_section_heading.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/notifications/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAccountCubit(),
      child: const Scaffold(
        appBar: FlexAppBar(
          title: Text('My Account'),
        ),
        body: MyAccountView(),
      ),
    );
  }
}

class MyAccountView extends StatelessWidget {
  const MyAccountView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        context.select((MyAccountCubit cubit) => cubit.state.isLoggedIn);
    final user = context.select((MyAccountCubit cubit) => cubit.state.user);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AccountHeader(user: user),
          const SizedBox(height: FlexSizes.spacerItems),
          if (isLoggedIn) ...[
            const SettingsSectionHeading(title: 'Account Settings'),
            SettingsListTile(
              title: 'Order History',
              subtitle: 'View your previous orders',
              trailing: const Icon(LineAwesome.arrow_right_solid),
              onTap: () {},
            ),
            SettingsListTile(
              title: 'Address Book',
              subtitle: 'Manage your shipping addresses',
              trailing: const Icon(LineAwesome.arrow_right_solid),
              onTap: () => context.router.pushNamed('address'),
            ),
            SettingsListTile(
              title: 'Payment Methods',
              subtitle: 'Manage your payment methods',
              trailing: const Icon(LineAwesome.arrow_right_solid),
              onTap: () {},
            ),
            SettingsListTile(
              title: 'Recently Viewed',
              subtitle: 'View your recently viewed products',
              trailing: const Icon(LineAwesome.arrow_right_solid),
              onTap: () {},
            ),
            const SizedBox(height: FlexSizes.spacerSection),
          ],
          const SettingsSectionHeading(title: 'App Settings'),
          SettingsListTile(
            title: 'Push Notifications',
            subtitle: 'Configure push notification settings',
            trailing: const Icon(LineAwesome.arrow_right_solid),
            onTap: () async {
              await openAppSettings();
              NotificationRepository.instance.printDebugInfo();
            },
          ),
          SettingsListTile(
            title: 'Change Language',
            subtitle: 'View your previous orders',
            trailing: const Icon(LineAwesome.arrow_right_solid),
            onTap: () {},
          ),
          SettingsListTile(
            title: 'Clear App Data',
            subtitle: 'Clear all app data and cache',
            trailing: const Icon(LineAwesome.arrow_right_solid),
            onTap: () => context.read<MyAccountCubit>().clearAppData(),
          ),
          const SizedBox(height: FlexSizes.spacerSection),
          const SettingsSectionHeading(title: 'Customer Service'),
          SettingsListTile(
            title: 'App Feedback',
            subtitle: 'Send us your feedback',
            trailing: const Icon(LineAwesome.arrow_right_solid),
            onTap: () {},
          ),
          SettingsListTile(
            title: 'Privacy & Terms',
            subtitle: 'View our privacy policy and terms of service',
            trailing: const Icon(LineAwesome.arrow_right_solid),
            onTap: () {},
          ),
          SettingsListTile(
            title: 'Contact Us',
            subtitle: 'Get in touch with customer service',
            trailing: const Icon(LineAwesome.arrow_right_solid),
            onTap: () {},
          ),
          if (isLoggedIn) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(FlexSizes.appPadding),
              child: ElevatedButton(
                onPressed: () => context.read<MyAccountCubit>().logout(),
                child: const Text('Sign Out'),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
