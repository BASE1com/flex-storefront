import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/router.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsHeader extends StatelessWidget {
  const SearchResultsHeader({
    super.key,
    required this.searchResults,
  });

  final SearchResults searchResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${searchResults.pagination.totalResults} items'),
        Row(
          children: [
            TextButton.icon(
              onPressed: () async {
                final result = await context.router
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
              onPressed: () {
                // Add filter logic
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
