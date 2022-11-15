import 'package:flutter/material.dart';
import 'package:theme/layout/app_config.dart';

class FormDropDownInput extends StatelessWidget {
  const FormDropDownInput(
      {super.key,
      required this.child,
      Color? backgroundColor,
      EdgeInsets? padding})
      : backgroundColor = backgroundColor ?? AppColors.editTextColor,
        padding = const EdgeInsets.symmetric(horizontal: 10);

  final Color backgroundColor;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.editTextRadius),
          ),
          color: backgroundColor),
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: child,
          ),
        ],
      ),
    );
  }
}
