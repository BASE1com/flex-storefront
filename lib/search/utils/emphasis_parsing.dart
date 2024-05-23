import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

mixin EmphasisParsing {
  Widget toRichText(String htmlString) {
    final parsedHtml = parse(htmlString);
    final nodes = parsedHtml.getElementsByTagName('body')[0].nodes;

    return RichText(
      maxLines: null, // Authorize multi-lines without limit
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: FlexSizes.fontSizeLg,
        ),
        children: nodes.map(
          (node) {
            final emphasis = node is dom.Element && node.localName == 'em';

            return TextSpan(
              text: node.text,
              style: TextStyle(
                fontWeight: emphasis ? FontWeight.bold : FontWeight.normal,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
