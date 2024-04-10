import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {
                // Add sort logic
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
