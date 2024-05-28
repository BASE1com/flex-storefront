import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

enum EmphasisTextStyle {
  bold(
    regularStyle: TextStyle(
      color: Colors.black,
      fontSize: FlexSizes.fontSizeLg,
      fontWeight: FontWeight.normal,
    ),
    emphasisStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  invertedBold(
    regularStyle: TextStyle(
      color: Colors.black,
      fontSize: FlexSizes.fontSizeLg,
      fontWeight: FontWeight.bold,
    ),
    emphasisStyle: TextStyle(
      fontWeight: FontWeight.normal,
    ),
  ),
  italic(
    regularStyle: TextStyle(
      color: Colors.black,
      fontSize: FlexSizes.fontSizeLg,
      fontWeight: FontWeight.normal,
    ),
    emphasisStyle: TextStyle(
      fontStyle: FontStyle.italic,
    ),
  );

  const EmphasisTextStyle({
    required this.regularStyle,
    required this.emphasisStyle,
  });

  final TextStyle regularStyle;
  final TextStyle emphasisStyle;
}

class EmphasisText extends StatelessWidget {
  const EmphasisText({
    super.key,
    required this.htmlString,
    required this.style,
  });

  /// Text content formatted in HTML. Only the <em> tags are parsed.
  final String htmlString;

  final EmphasisTextStyle style;

  @override
  Widget build(BuildContext context) {
    final parsedHtml = parse(htmlString);
    final nodes = parsedHtml.getElementsByTagName('body')[0].nodes;

    return RichText(
      maxLines: null, // Authorize multi-lines without limit
      text: TextSpan(
        style: style.regularStyle,
        children: nodes.map(
          (node) {
            final emphasis = node is dom.Element && node.localName == 'em';

            return TextSpan(
              text: node.text,
              style: emphasis ? style.emphasisStyle : null,
            );
          },
        ).toList(),
      ),
    );
  }
}
