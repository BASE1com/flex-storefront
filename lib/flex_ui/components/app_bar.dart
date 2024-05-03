import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class FlexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlexAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon = LineAwesome.arrow_left_solid,
    this.actions,
    this.onLeadingPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? onLeadingPressed;

  @override
  Widget build(BuildContext context) {
    final fromTab = RouteData.of(context).queryParams.optInt('fromTab');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: FlexSizes.appPadding),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: onLeadingPressed ??
                    () {
                      if (fromTab != null) {
                        AutoTabsRouter.of(context).setActiveIndex(fromTab);
                      }

                      AutoRouter.of(context).maybePop();
                    },
                icon: Icon(leadingIcon),
              )
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(FlexSizes.appBarHeight);
}

@widgetbook.UseCase(
  name: 'Default',
  type: FlexAppBar,
)
Widget defaultAppBar(BuildContext context) {
  return FlexAppBar(
    title: const Text('Page Title'),
    showBackArrow:
        context.knobs.boolean(label: 'Show Back Arrow', initialValue: false),
  );
}
