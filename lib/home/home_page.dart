import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/cms/cubits/cms_cubit.dart';
import 'package:flex_storefront/cms/cubits/cms_state.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/home/home_page_content.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: FlexColors.primary,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            )
          ],
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Container(
                color: FlexColors.primary,
                alignment: Alignment.center,
                child: const CachedImage(
                  width: 200,
                  url:
                      // TODO Replace with the media permalink corresponding to this image
                      'https://spartacus-demo.eastus.cloudapp.azure.com:8443/medias/SAP-scrn-R.png?context=bWFzdGVyfGltYWdlc3wxMDEyN3xpbWFnZS9wbmd8YVcxaFoyVnpMMmhrTmk5b09UTXZPRGM1TnpRNU5qazJOekU1T0M1d2JtY3wzZDU0YTQxNDExOGNhYTczZTViNjllMWIyNDFhMzBkOThmNTRmMTU2MjgwZDM3ZWYxNjIyNzY5MTY5M2M2YmU0',
                  placeholder: SizedBox.shrink(),
                  error: SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<CmsCubit, CmsState>(
            builder: (_, state) {
              switch (state.status) {
                case Status.pending:
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
