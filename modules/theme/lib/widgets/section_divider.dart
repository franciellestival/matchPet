import 'package:flutter/material.dart';
import 'package:theme/export_theme.dart';

class SectionDivider extends StatelessWidget {
  final String? title;
  final Function? onTapCallToAction;
  final bool showCallToAction;

  const SectionDivider({
    this.title,
    this.onTapCallToAction,
    this.showCallToAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            title!,
            style: themeData.textTheme.headline2,
          ),
        ),
      ],
    );
  }
}
