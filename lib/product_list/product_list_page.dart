import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/product_list_item.dart';
import 'package:flex_storefront/flex_ui/widgets/product_list_item_shimmer.dart';
import 'package:flex_storefront/flex_ui/widgets/search_results_header.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/product_list/cubits/product_search_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        context.read<ProductSearchCubit>().nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchCubit, ProductSearchState>(
      builder: (context, state) {
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
            if (state.status == Status.failure)
              const Center(child: Text('Failed to load products')),
            Expanded(
              child: ListView.separated(
                controller: controller,
                itemCount: state.products.length + 1,
                separatorBuilder: (_, __) => Divider(
                  height: 0,
                  color: Colors.grey[200],
                ),
                itemBuilder: (context, i) {
                  // handle the last item
                  if (i == state.products.length) {
                    if (state.status == Status.pending) {
                      return const ProductListItemShimmer();
                    }

                    return state.pagination.currentPage + 1 >=
                            state.pagination.totalPages
                        ? const Center(child: Text('No more products to load'))
                        : const ProductListItemShimmer();
                  }

                  return ProductListItem(product: state.products[i]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
