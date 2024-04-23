import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/pill.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class FilterPage extends StatelessWidget {
  final List<Facet> facets;

  const FilterPage({
    super.key,
    this.facets = const [],
  });

  @override
  Widget build(BuildContext context) {
    final sortedFacets = facets
      ..sort((a, b) => a.priority.compareTo(b.priority));

    return Scaffold(
      appBar: FlexAppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () => context.router.root.back(),
            icon: const Icon(LineAwesome.times_solid),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: FlexSizes.appPadding,
            vertical: FlexSizes.appBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sortedFacets.map((e) {
              return FilterSection(facet: e);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.facet,
  });

  final Facet facet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          facet.name,
          style: const TextStyle(
            fontSize: FlexSizes.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: FlexSizes.spacerItems),
        Wrap(
          children: facet.values.map((value) {
            return FlexPill(
              text: '${value.name} (${value.count})',
              onTap: () async {
                context.router.maybePop<FacetValue>(value);
              },
              margin: const EdgeInsets.only(right: 8, bottom: 8),
            );
          }).toList(),
        ),
        const SizedBox(height: FlexSizes.spacerSection),
      ],
    );
  }
}
