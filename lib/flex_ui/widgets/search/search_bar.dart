import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/navigation_helper.dart';
import 'package:flutter/material.dart';

class FlexSearchBar extends StatelessWidget {
  const FlexSearchBar({
    super.key,
    this.autoFocus = false,
    this.onChanged,
  });

  final bool autoFocus;

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      autoFocus: autoFocus,
      textInputAction: TextInputAction.search,
      leading: const Padding(
        padding: EdgeInsets.only(left: FlexSizes.sm),
        child: Icon(Icons.search_rounded),
      ),
      hintText: 'What are you looking for?',
      onChanged: onChanged,
      onSubmitted: (value) {
        // So if the search is initiated from the Home tab, the back button
        // brings back to the Home tab.
        final fromTab = RouteData.of(context).queryParams.optInt('fromTab');

        context.maybePop();
        context.router.navigateNamed(
          '/shop/search?searchTerm=$value'.withTabArg(fromTab),
        );
      },
    );
  }
}
