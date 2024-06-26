import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/router.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultsHeader extends StatelessWidget {
  const SearchResultsHeader({
    super.key,
    this.breadcrumbs = const [],
    required this.searchResults,
  });

  final List<Breadcrumb> breadcrumbs;
  final SearchResults searchResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (breadcrumbs.isNotEmpty)
          BreadCrumb(
            divider: Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey[700],
            ),
            items: [
              BreadCrumbItem(
                content: const Text(
                  'All',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () => context.router.popUntilRoot(),
              ),
              ...breadcrumbs
                  .map(
                    (e) => BreadCrumbItem(
                      content: Text(
                        e.facetValueName ?? '',
                        style: TextStyle(
                          color: e.truncateQuery != null ? Colors.blue : null,
                        ),
                      ),
                      onTap: e.truncateQuery != null
                          ? () => context.router.popAndPush(
                                ProductListRoute(
                                    categoryCode: e.facetValueCode),
                              )
                          : null,
                    ),
                  )
                  .toList()
            ],
          ),
        Row(
          children: [
            Text('${searchResults.pagination.totalResults} items'),
            const Spacer(),
            TextButton.icon(
              onPressed: () async {
                final result = await context.router.root
                    .push<Sort?>(SortRoute(sorts: searchResults.sorts));

                if (context.mounted && result != null) {
                  context
                      .read<ProductSearchCubit>()
                      .searchProducts(sortBy: result);
                }
              },
              icon: const Icon(Icons.swap_vert_rounded),
              label: const Text('Sort'),
            ),
            const SizedBox(width: 4.0),
            TextButton.icon(
              onPressed: () async {
                final result = await context.router.root.push<FacetValue?>(
                    FilterRoute(facets: searchResults.facets));

                if (context.mounted && result != null) {
                  context
                      .read<ProductSearchCubit>()
                      .searchProducts(filterBy: result);
                }
              },
              icon: const Icon(Icons.tune_rounded),
              label: Text('Filter (${searchResults.facets.length})'),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchResultsHeaderShimmer extends StatelessWidget {
  const SearchResultsHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FlexSizes.md),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              height: FlexSizes.fontSizeMd,
              color: Colors.white,
            ),
            const SizedBox(height: FlexSizes.spacerItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 96,
                  height: FlexSizes.fontSizeMd,
                  color: Colors.white,
                ),
                Container(
                  width: 160,
                  height: FlexSizes.fontSizeMd,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
