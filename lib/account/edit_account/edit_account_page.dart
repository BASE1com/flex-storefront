import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/edit_account/cubits/edit_account_cubit.dart';
import 'package:flex_storefront/account/widgets/settings_section_heading.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EditAccountPage extends StatelessWidget {
  const EditAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAccountCubit(),
      child: const Scaffold(
        appBar: FlexAppBar(
          title: Text('Edit Profile'),
          showBackArrow: true,
          showSearchButton: false,
        ),
        body: EditAccountView(),
      ),
    );
  }
}

class EditAccountView extends StatelessWidget {
  const EditAccountView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.select((EditAccountCubit cubit) => cubit.state.user);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(FlexSizes.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // profile information
            const SettingsSectionHeading(
              title: 'Profile information',
            ),
            const SizedBox(height: FlexSizes.spacerItems),
            SettingsValueListTile(
              title: 'Title',
              value: user.title ?? 'None',
            ),
            SettingsValueListTile(
              title: 'Name',
              value: user.name,
            ),
            SettingsValueListTile(
              title: 'Customer #',
              value: user.customerId,
              showTrailingArrow: false,
            ),

            const SizedBox(height: FlexSizes.spacerSection),

            // personal info
            const SettingsSectionHeading(
              title: 'Personal information',
            ),
            const SizedBox(height: FlexSizes.spacerItems),
            SettingsValueListTile(
              title: 'Email',
              value: user.displayUid,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsValueListTile extends StatelessWidget {
  const SettingsValueListTile({
    super.key,
    required this.title,
    required this.value,
    this.showTrailingArrow = true,
  });

  final String title;
  final String value;
  final bool showTrailingArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FlexSizes.appPadding,
        vertical: FlexSizes.spacerItems,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: FlexColors.disabled,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
          showTrailingArrow
              ? const Icon(Icons.chevron_right, size: FlexSizes.iconMd)
              : const SizedBox(width: FlexSizes.iconMd),
        ],
      ),
    );
  }
}
