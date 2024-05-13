import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/cms/cubits/cms_cubit.dart';
import 'package:flex_storefront/cms/cubits/cms_state.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/home/home_page_content.dart';
import 'package:flex_storefront/flex_ui/widgets/search/search_bar.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CmsCubit>(
      create: (_) => CmsCubit()..loadHomepageContent(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;
  double expandedHeight = 132;
  bool lastStatus = true;

  bool get _isShrunk {
    return _scrollController.hasClients &&
        _scrollController.offset > (expandedHeight - kToolbarHeight);
  }

  void _scrollListener() {
    if (_isShrunk != lastStatus) {
      setState(() {
        lastStatus = _isShrunk;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: FlexColors.primary,
          pinned: true,
          expandedHeight: expandedHeight,
          title: Row(
            children: [
              const CachedImage(
                height: kToolbarHeight * 0.6,
                url:
                    // TODO Replace with the media permalink corresponding to this image
                    'https://spartacus-demo.eastus.cloudapp.azure.com:8443/medias/SAP-scrn-R.png?context=bWFzdGVyfGltYWdlc3wxMDEyN3xpbWFnZS9wbmd8YVcxaFoyVnpMMmhrTmk5b09UTXZPRGM1TnpRNU5qazJOekU1T0M1d2JtY3wzZDU0YTQxNDExOGNhYTczZTViNjllMWIyNDFhMzBkOThmNTRmMTU2MjgwZDM3ZWYxNjIyNzY5MTY5M2M2YmU0',
                placeholder: SizedBox.shrink(),
                error: SizedBox.shrink(),
              ),
              const SizedBox(width: FlexSizes.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: FlexColors.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'SAP Electronics Store',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: FlexColors.onPrimary),
                  ),
                ],
              ),
            ],
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Container(
                color: FlexColors.primary,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: FlexSizes.appBarHeight),
                child: const FlexSearchBar(),
              ),
            ),
          ),
          actions: [
            if (_isShrunk)
              IconButton(
                icon: const Icon(
                  LineAwesome.search_solid,
                  color: FlexColors.onPrimary,
                ),
                onPressed: () {
                  // TODO: Handle search button press
                },
              ),
          ],
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<CmsCubit, CmsState>(
            builder: (_, state) {
              switch (state.status) {
                case Status.initial || Status.pending:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.success:
                  return HomePageContent(sections: state.sections);
                case Status.failure:
                  return Center(
                    child: Column(
                      children: [
                        const Text('Content loading failed'),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CmsCubit>().loadHomepageContent();
                          },
                          child: const Text('Retry'),
                        )
                      ],
                    ),
                  );
              }
            },
          ),
        )
      ],
    );
  }
}
