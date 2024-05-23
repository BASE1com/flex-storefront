import 'package:flex_storefront/search/utils/emphasis_parsing.dart';
import 'package:flutter/material.dart';

class TextSuggestion extends StatelessWidget with EmphasisParsing {
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

      text = toRichText(htmlSuggestion);
    } else {
      text = Text(query!);
    }

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: padding,
        child: text,
      ),
    );
  }
}
