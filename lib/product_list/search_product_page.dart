import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/product_list/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SearchProductPage extends StatelessWidget {
  final String? searchTerm;

  const SearchProductPage({
    super.key,
    @QueryParam() this.searchTerm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlexAppBar(
        title: Text('Search $searchTerm'),
        showBackArrow: true,
      ),
      body: BlocProvider<ProductSearchCubit>(
        create: (context) {
          return ProductSearchCubit()..searchProducts(searchTerm: searchTerm);
        },
        child: const ProductListView(),
      ),
    );
  }
}
