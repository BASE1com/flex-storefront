import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/search/cubits/suggestion_cubit.dart';
import 'package:flex_storefront/search/widgets/product_suggestion.dart';
import 'package:flex_storefront/search/widgets/text_suggestion.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestionState = context.watch<SuggestionCubit>().state;
    final productState = context.watch<ProductSearchCubit>().state;
    final isPending = suggestionState.status == Status.pending ||
        productState.status == Status.pending;

    final children = <Widget>[
      if (isPending &&
          suggestionState.suggestions.isEmpty &&
          productState.products.isEmpty)
        const Center(child: CircularProgressIndicator()),
      for (var s in suggestionState.suggestions) ...[
        Divider(
          height: 1,
          color: Colors.black.withOpacity(0.1),
        ),
        TextSuggestion(
          suggestion: s,
          query: suggestionState.query,
          padding: const EdgeInsets.all(FlexSizes.md),
        ),
      ],
      for (var p in productState.products) ...[
        Divider(
          height: 1,
          color: Colors.black.withOpacity(0.1),
        ),
        ProductSuggestion(
          product: p,
          padding: const EdgeInsets.symmetric(
            vertical: FlexSizes.sm,
            horizontal: FlexSizes.md,
          ),
        ),
      ]
    ];

    return ListView(
      children: children,
    );
  }
}
