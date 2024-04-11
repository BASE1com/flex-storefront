import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_cubit.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_state.dart';
import 'package:flex_storefront/product_detail/widgets/product_detail_content.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    @pathParam required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailCubit>(
      create: (context) =>
          ProductDetailCubit()..loadProduct(productId: productId),
      child: const ProductDetailView(),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final productName =
        context.select((ProductDetailCubit cubit) => cubit.state.product?.name);

    return Scaffold(
      appBar: AppBar(
        title: productName != null ? Text(productName) : null,
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.success:
              return const ProductDetailContent();
            case Status.failure:
              return const Center(
                child: Text('Failed to load product'),
              );
          }
        },
      ),
    );
  }
}