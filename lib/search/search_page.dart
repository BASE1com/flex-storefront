import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/search/search_bar.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/product_list/cubits/product_search_state.dart';
import 'package:flex_storefront/search/widgets/autocomplete_product.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductSearchCubit>(
      create: (_) => ProductSearchCubit(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fromTab = RouteData.of(context).queryParams.optInt('fromTab');

    return Scaffold(
      appBar: FlexAppBar(
        showSearchButton: false,
        showBackArrow: true,
        leadingIcon: LineAwesome.times_solid,
        title: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.all(4.0),
          child: FlexSearchBar(
            autoFocus: true,
            fromTab: fromTab,
            onChanged: (value) {
              BlocProvider.of<ProductSearchCubit>(context)
                  .searchProductsAutocomplete(query: value);
            },
          ),
        ),
      ),
      body: BlocBuilder<ProductSearchCubit, ProductSearchState>(
        builder: (_, state) {
          final children = <Widget>[
            if (state.status == Status.pending && state.products.isEmpty)
              const Center(child: CircularProgressIndicator()),
            for (var p in state.products) ...[
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.1),
              ),
              AutocompleteProduct(
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
        },
      ),
    );
  }
}
