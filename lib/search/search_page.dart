import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/widgets/search/search_bar.dart';
import 'package:flex_storefront/product_list/cubits/product_search_cubit.dart';
import 'package:flex_storefront/search/cubits/suggestion_cubit.dart';
import 'package:flex_storefront/search/search_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductSearchCubit>(
          create: (_) => ProductSearchCubit(),
        ),
        BlocProvider<SuggestionCubit>(
          create: (_) => SuggestionCubit(),
        ),
      ],
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
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
            onChanged: (value) {
              BlocProvider.of<ProductSearchCubit>(context)
                  .searchProductsAutocomplete(query: value);
              BlocProvider.of<SuggestionCubit>(context).loadSuggestions(value);
            },
          ),
        ),
      ),
      body: const SearchContent(),
    );
  }
}
