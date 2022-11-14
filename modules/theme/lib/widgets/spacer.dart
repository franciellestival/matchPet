// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  final double? height;

  // ignore: use_key_in_widget_constructors
  const HeightSpacer({
    height,
  }) : height = 20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class WidthSpacer extends StatelessWidget {
  final double? width;

  // ignore: use_key_in_widget_constructors
  const WidthSpacer({
    width,
  }) : width = 20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
