import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/widgets/product_list_item.dart';
import 'package:flex_storefront/flex_ui/widgets/search_results_header.dart';
import 'package:flex_storefront/product_list/cubits/product_list_cubit.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: BlocProvider<ProductListCubit>(
        create: (context) {
          return ProductListCubit()..loadProducts();
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
    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        switch (state.status) {
          case ProductListStatus.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ProductListStatus.success:
            return Column(
              children: [
                if (state.searchResults != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchResultsHeader(
                        searchResults: state.searchResults!),
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
          case ProductListStatus.failure:
            return const Center(
              child: Text('Failed to load products'),
            );
        }
      },
    );
  }
}
