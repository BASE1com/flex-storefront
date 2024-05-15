import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/widgets/search/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchView();
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final fromTab = RouteData.of(context).queryParams.optInt('fromTab');

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
            fromTab: fromTab,
          ),
        ),
      ),
    );
  }
}
