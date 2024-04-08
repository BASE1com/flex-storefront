import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/category/cubits/category_cubit.dart';
import 'package:flex_storefront/category/cubits/category_state.dart';
import 'package:flex_storefront/router.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
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
            return ListView(
              children: state.categories
                  .map(
                    (category) => ListTile(
                      title: Text(category.name),
                      onTap: () {
                        context.router.pushNamed(
                          'category/${category.id}?title=${category.name}',
                        );
                      },
                    ),
                  )
                  .toList(),
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
