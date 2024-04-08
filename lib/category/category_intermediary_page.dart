import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/category/cubits/category_intermediary_cubit.dart';
import 'package:flex_storefront/category/cubits/category_intermediary_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CategoryIntermediaryPage extends StatelessWidget {
  final int categoryId;
  final String? title;

  const CategoryIntermediaryPage({
    super.key,
    @PathParam() required this.categoryId,
    @QueryParam() this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
      ),
      body: BlocProvider<CategoryIntermediaryCubit>(
        create: (context) {
          return CategoryIntermediaryCubit()
            ..loadCategory(categoryId: categoryId);
        },
        child: CategoryIntermediaryView(categoryId: categoryId),
      ),
    );
  }
}

class CategoryIntermediaryView extends StatelessWidget {
  final int categoryId;

  const CategoryIntermediaryView({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryIntermediaryCubit, CategoryIntermediaryState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.success:
            final category = state.category!;

            return ListView(
              children: category.children
                  .map(
                    (category) => ListTile(
                      title: Text(category.name),
                      onTap: () {
                        if (category.children.isNotEmpty) {
                          context.router.pushNamed(
                            'category/${category.id}?title=${category.name}',
                          );
                        } else {
                          // TODO navigate to PLP
                        }
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
                      context
                          .read<CategoryIntermediaryCubit>()
                          .loadCategory(categoryId: categoryId);
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
