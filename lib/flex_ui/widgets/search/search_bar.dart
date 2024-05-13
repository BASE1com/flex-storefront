import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexSearchBar extends StatelessWidget {
  const FlexSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.fromLTRB(
        FlexSizes.appPadding,
        FlexSizes.xs,
        FlexSizes.appPadding,
        FlexSizes.xs,
      ),
      child: const SearchBar(
        leading: Padding(
          padding: EdgeInsets.only(left: FlexSizes.sm),
          child: Icon(Icons.search_rounded),
        ),
        hintText: 'What are you looking for?',
      ),
    );
  }
}
