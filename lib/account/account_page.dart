import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/widgets/account_header.dart';
import 'package:flex_storefront/account/widgets/settings_list_tile.dart';
import 'package:flex_storefront/account/widgets/settings_section_heading.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlexAppBar(
        title: Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AccountHeader(),
            const SizedBox(height: FlexSizes.spacerSection),
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
              onTap: () {},
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
            const SettingsSectionHeading(title: 'App Settings'),
            SettingsListTile(
              title: 'Notifications',
              subtitle: 'Manage your notification settings',
              trailing: const Icon(LineAwesome.arrow_right_solid),
              onTap: () {},
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
              onTap: () {},
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
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(FlexSizes.appPadding),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
