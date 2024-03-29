// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/layout/app_config.dart';

class FormInputBox extends StatelessWidget {
  FormInputBox({
    Key? key,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.validator,
    Color? backgroundColor,
    Color? textColor,
    this.suffixIcon,
    this.horizontalAxisAlignment = MainAxisAlignment.start,
    EdgeInsets? padding,
    double? borderRadius,
    this.textInputType,
    this.enable,
  })  : backgroundColor = backgroundColor ?? AppColors.editTextColor,
        textColor = textColor ?? AppColors.white,
        borderRadius = borderRadius ?? AppRadius.editTextRadius,
        padding = const EdgeInsets.symmetric(horizontal: 10),
        super(key: key);

  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final MainAxisAlignment horizontalAxisAlignment;
  final Color textColor;
  final double borderRadius;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? enable;
  final TextInputType? textInputType;
  final Widget? suffixIcon;

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
            child: TextFormField(
              keyboardType: textInputType,
              enabled: enable ?? true,
              cursorColor: AppColors.buttonColor,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                border: InputBorder.none,
                errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.buttonRadius)),
                  borderSide: const BorderSide(color: AppColors.buttonColor),
                ),
                label: Text.rich(TextSpan(
                    children: <InlineSpan>[WidgetSpan(child: Text(hintText))])),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              controller: controller,
              inputFormatters: inputFormatters,
            ),
          )
        ],
      ),
    );
  }
}
