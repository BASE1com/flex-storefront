import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/navigation_helper.dart';
import 'package:flutter/material.dart';

class FlexSearchBar extends StatelessWidget {
  const FlexSearchBar({
    super.key,
    this.autoFocus = false,
    this.fromTab,
  });

  final bool autoFocus;

  /// Customize the search result page back button behavior.
  /// Example: if the search is initiated from the Home tab, the back button
  /// on the search result page brings back to the Home tab.
  final int? fromTab;

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
      onSubmitted: (value) {
        context.maybePop();
        context.router.navigateNamed(
          '/shop/search?searchTerm=$value'.withTabArg(fromTab),
        );
      },
    );
  }
}
