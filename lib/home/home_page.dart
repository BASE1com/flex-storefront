import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        const SliverFillRemaining(
          child: Center(
            child: Text('Home Page'),
          ),
        )
      ],
    );
  }
}
