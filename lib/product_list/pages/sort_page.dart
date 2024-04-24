import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/pill.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class SortPage extends StatelessWidget {
  final List<Sort> sorts;

  const SortPage({
    super.key,
    this.sorts = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              'Sort by',
              style: TextStyle(
                fontSize: FlexSizes.fontSizeXl,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () => context.router.root.back(),
              icon: const Icon(LineAwesome.times_solid),
            ),
          ],
        ),
        const SizedBox(height: FlexSizes.spacerItems),
        Wrap(
          children: sorts.map((sort) {
            return FlexPill(
              text: sort.name,
              isSelected: sort.selected,
              onTap: () async {
                context.router.maybePop<Sort>(sort);
              },
              margin: const EdgeInsets.only(right: 8, bottom: 8),
            );
          }).toList(),
        ),
      ],
    );
  }
}
