// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flex_storefront/flex_ui/components/app_bar.dart' as _i2;
import 'package:flex_storefront/flex_ui/components/carousel.dart' as _i3;
import 'package:flex_storefront/flex_ui/components/gallery.dart' as _i4;
import 'package:flex_storefront/flex_ui/widgets/ecommerce/add_to_cart_button.dart'
    as _i5;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'flex_ui',
    children: [
      _i1.WidgetbookFolder(
        name: 'components',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'FlexAppBar',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i2.defaultAppBar,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FlexCarousel',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.defaultCarousel,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FlexGallery',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i4.defaultCarousel,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'widgets',
        children: [
          _i1.WidgetbookFolder(
            name: 'ecommerce',
            children: [
              _i1.WidgetbookComponent(
                name: 'AddToCartButton',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Disabled',
                    builder: _i5.disabledButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Enabled',
                    builder: _i5.enabledButton,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ],
  )
];
