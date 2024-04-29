import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/product_list_item.dart';
import 'package:flex_storefront/flex_ui/widgets/search_results_header.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/product_list/cubits/product_search_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductListPage extends StatelessWidget {
  final String? categoryCode;

  const ProductListPage({
    super.key,
    @QueryParam() this.categoryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlexAppBar(
        title: Text('Product List'),
        showBackArrow: true,
      ),
      body: BlocProvider<ProductSearchCubit>(
        create: (context) {
          return ProductSearchCubit()
            ..searchProducts(categoryCode: categoryCode);
        },
        child: const ProductListView(),
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchCubit, ProductSearchState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.success:
            return Column(
              children: [
                if (state.searchResults != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: FlexSizes.appPadding,
                    ),
                    child: SearchResultsHeader(
                      breadcrumbs: state.breadcrumbs,
                      searchResults: state.searchResults!,
                    ),
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.products.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 0,
                      color: Colors.grey[200],
                    ),
                    itemBuilder: (context, i) {
                      final product = state.products[i];

                      return ProductListItem(product: product);
                    },
                  ),
                ),
              ],
            );
          case Status.failure:
            return const Center(
              child: Text('Failed to load products'),
            );
        }
      },
    );
  }
}
