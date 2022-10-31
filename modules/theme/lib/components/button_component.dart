import 'package:flutter/material.dart';
import 'package:theme/layout/app_config.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    Color? backgroundColor,
    Color? disabledColor,
    Color? textColor,
    this.horizontalAxisAlignment = MainAxisAlignment.center,
    EdgeInsets? padding,
    double? borderRadius,
  })  : backgroundColor = backgroundColor ?? AppColors.buttonColor,
        textColor = textColor ?? AppColors.white,
        borderRadius = borderRadius ?? AppRadius.buttonRadius,
        padding = const EdgeInsets.all(10),
        super(key: key);

  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final MainAxisAlignment horizontalAxisAlignment;
  final Function onTap;
  final Color textColor;
  final double borderRadius;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap as void Function()?,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        fixedSize: MaterialStateProperty.all(
          const Size(315, 54),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
