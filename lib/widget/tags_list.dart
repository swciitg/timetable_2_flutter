import 'package:flutter/material.dart';

class TagsList extends StatelessWidget {
  final List<String> tags;
  TagsList(this.tags);

  List<TextSpan> textTag(context, tsFactor, tag) {
    return [
      TextSpan(
        text: " . ",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: tsFactor * 25,
        ),
      ),
      TextSpan(
        text: tag,
      ),
    ];
  }

  List<TextSpan> textSpans(BuildContext context, tsFactor) {
    List<TextSpan> listOfSpans = [];
    tags.forEach((tag) {
      if (tags.indexOf(tag) != 0) {
        listOfSpans.add(
          TextSpan(
            text: " . ",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: tsFactor * 25,
            ),
          ),
        );
        listOfSpans.add(
          TextSpan(
            text: tag,
          ),
        );
      }
    });
    return listOfSpans;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final tsFactor = mediaQuery.textScaleFactor;
    return RichText(
      text: TextSpan(
        text: tags.isEmpty ? "No tags given " : tags[0],
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: tsFactor * 13,
        ),
        children: textSpans(context, tsFactor),
      ),
    );
  }
}
