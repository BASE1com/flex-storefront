import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/layouts/modal_draggable_sheet.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/pill.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class SortPage extends StatelessWidget with DraggableScrollControllerMixin {
  final List<Sort> sorts;

  const SortPage({
    super.key,
    this.sorts = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FlexSizes.appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: () => context.router.root.back(),
                icon: const Icon(LineAwesome.times_solid),
              )
            ],
          ),
          const SizedBox(height: FlexSizes.spacerSection),
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
      ),
    );
  }
}
