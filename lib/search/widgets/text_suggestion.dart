import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/search/utils/emphasis_parsing.dart';
import 'package:flex_storefront/shared/navigation_helper.dart';
import 'package:flutter/material.dart';

class TextSuggestion extends StatelessWidget {
  const TextSuggestion({
    super.key,
    required this.suggestion,
    this.query,
    this.padding = EdgeInsets.zero,
  });

  final String suggestion;

  /// Original query to lead to this suggestion. Used to emphasize the query
  /// included in the suggestion text.
  final String? query;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Widget text;
    if (query != null) {
      final htmlSuggestion = suggestion.replaceFirst(query!, '<em>$query</em>');

      text = EmphasisText(
        htmlString: htmlSuggestion,
        style: EmphasisTextStyle.invertedBold,
      );
    } else {
      text = Text(suggestion);
    }

    return InkWell(
      onTap: () {
        final fromTab = RouteData.of(context).queryParams.optInt('fromTab');

        context.router.maybePop();
        context.router.navigateNamed(
          '/shop/search?searchTerm=$suggestion'.withTabArg(fromTab),
        );
      },
      child: Padding(
        padding: padding,
        child: text,
      ),
    );
  }
}
