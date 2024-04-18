import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/carousel.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/flex_ui/widgets/selectable_image.dart';

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
          child: Column(
            children: [
              SizedBox(height: FlexSizes.spacerItems),
              FlexCarousel(
                items: [
                  SelectableImage(
                    imageUrl:
                        'https://spartacus-demo.eastus.cloudapp.azure.com:8443/medias/Elec-350x262-HomeFam-EN-01-350W.jpg?context=bWFzdGVyfGltYWdlc3wyMDg4M3xpbWFnZS9qcGVnfGFXMWhaMlZ6TDJnNU1TOW9Nell2T0RjNU56TTFOamc0TXprNU9DNXFjR2N8ZWY0YTI1MmQ4YmIwNmI4NDAxODJhZGIyMzYxODJkY2Q1YTUxNWU3MzFkNGU3NWE0ZGQ3OGM2OGI5ZjkyMmY5MA',
                    borderRadius: FlexSizes.borderRadiusMd,
                  ),
                  SelectableImage(
                    imageUrl:
                        'https://spartacus-demo.eastus.cloudapp.azure.com:8443/medias/Elec-350x262-HomeFamLight-EN-01-350W.jpg?context=bWFzdGVyfGltYWdlc3wxNzgzMHxpbWFnZS9qcGVnfGFXMWhaMlZ6TDJnMk55OW9OV1l2T0RjNU56TTFOamd4T0RRMk1pNXFjR2N8ODM2MjViNzMzZWQ2YmMxYzU3OGM0MWQ1ZGU4NjlkOTU5MzFkYzljMjFhNjE5NGE5ZDRlZTNmMTAxYWI1ZGI0ZA',
                    borderRadius: FlexSizes.borderRadiusMd,
                  ),
                  SelectableImage(
                    imageUrl:
                        'https://spartacus-demo.eastus.cloudapp.azure.com:8443/medias/Elec-350x262-HomeCaptureFirst-EN-01-350W.jpg?context=bWFzdGVyfGltYWdlc3wyMzAwOHxpbWFnZS9qcGVnfGFXMWhaMlZ6TDJnMFlpOW9PREF2T0RjNU56TTFOekl4TVRZM09DNXFjR2N8MGI3NWViYWU3YWU0ZGQwYjBhNGQzNDdmNjIwOGMyMWI1MTMyOThhZmVhMjI4OGEzY2ExODhhOGZjMTRlNWQzMg',
                    borderRadius: FlexSizes.borderRadiusMd,
                  ),
                ],
              ),
              SizedBox(height: FlexSizes.spacerSection),
              Text('Home page'),
            ],
          ),
        )
      ],
    );
  }
}
