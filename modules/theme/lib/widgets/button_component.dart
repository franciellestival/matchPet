// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    double? height,
    double? width,
    double? fontSize,
    FontWeight? fontWeight,
    this.isLoading,
  })  : backgroundColor = backgroundColor ?? AppColors.buttonColor,
        textColor = textColor ?? AppColors.white,
        borderRadius = borderRadius ?? AppRadius.buttonRadius,
        padding = padding ?? const EdgeInsets.all(10),
        height = height ?? 54,
        width = width ?? 315,
        fontSize = fontSize ?? 20,
        fontWeight = fontWeight ?? FontWeight.bold,
        super(key: key);

  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final MainAxisAlignment horizontalAxisAlignment;
  final Function onTap;
  final Color textColor;
  final double borderRadius;
  final String text;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  RxBool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap as void Function()?,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            fixedSize: MaterialStateProperty.all(
              Size(width, height),
            ),
            padding: MaterialStateProperty.all(
              padding,
            )),
        child: Obx(
          () {
            isLoading ??= false.obs;
            return isLoading!.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: fontWeight,
                    ),
                  );
          },
        ));
  }
}
