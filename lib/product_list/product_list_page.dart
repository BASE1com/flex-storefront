import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/product_list/cubits/product_list_cubit.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return ListView(
              children: state.products
                  .map(
                    (product) => ListTile(
                      title: Text(product.name),
                      onTap: () {},
                    ),
                  )
                  .toList(),
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
