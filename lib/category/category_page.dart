import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/category/cubits/category_cubit.dart';
import 'package:flex_storefront/category/cubits/category_state.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/layouts/grid_layout.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/category_card.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlexAppBar(
        title: Text('Shop All Categories'),
      ),
      body: BlocProvider<CategoryCubit>(
        create: (context) {
          return CategoryCubit()..loadCategories();
        },
        child: const CategoryView(),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.success:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: FlexSizes.appPadding),
                child: FlexGridLayout(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return CategoryCard(
                      title: category.name,
                      imageUrl:
                          'https://picsum.photos/240/240?random=${category.id}',
                      onPressed: () => context.router.pushNamed(
                        category.destination ??
                            'category/${category.id}?title=${category.name}',
                      ),
                    );
                  },
                ),
              ),
            );
          case Status.failure:
            return Center(
              child: Column(
                children: [
                  const Text('Category loading failed'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CategoryCubit>().loadCategories();
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}
