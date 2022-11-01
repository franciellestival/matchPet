// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
    this.horizontalAxisAlignment = MainAxisAlignment.start,
    EdgeInsets? padding,
    double? borderRadius,
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
              cursorColor: AppColors.buttonColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.buttonRadius)),
                  borderSide: const BorderSide(color: AppColors.buttonColor),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.hintTextColor,
                ),
              ),
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

class FormInputBoxPassword extends StatefulWidget {
  const FormInputBoxPassword({
    Key? key,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.validator,
    Color? backgroundColor,
    Color? textColor,
    this.horizontalAxisAlignment = MainAxisAlignment.start,
    EdgeInsets? padding,
    double? borderRadius,
  })  : backgroundColor = backgroundColor ?? AppColors.editTextColor,
        textColor = textColor ?? AppColors.white,
        // borderRadius = borderRadius ?? AppRadius().editTextRadius,
        borderRadius = borderRadius ?? 10.0,
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

  @override
  State<FormInputBoxPassword> createState() => _FormInputBoxPasswordState();
}

class _FormInputBoxPasswordState extends State<FormInputBoxPassword> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.editTextRadius),
          ),
          color: widget.backgroundColor),
      child: Column(
        children: [
          Padding(
            padding: widget.padding,
            child: TextFormField(
              cursorColor: AppColors.buttonColor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppRadius.buttonRadius)),
                    borderSide: const BorderSide(color: AppColors.buttonColor),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: AppColors.hintTextColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              validator: widget.validator,
              controller: widget.controller,
              inputFormatters: widget.inputFormatters,
              obscureText: !_passwordVisible,
              enableSuggestions: false,
              autocorrect: false,
            ),
          )
        ],
      ),
    );
  }
}

class FormDropDownInput extends StatelessWidget {
  FormDropDownInput(
      {super.key,
      required this.items,
      required this.hintText,
      Color? backgroundColor,
      EdgeInsets? padding})
      : backgroundColor = backgroundColor ?? AppColors.editTextColor,
        padding = const EdgeInsets.symmetric(horizontal: 10);

  final List<String> items;
  final Color backgroundColor;
  final EdgeInsets padding;
  final String hintText;
  Rx<String> selectedValue = ''.obs;

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
            child: DropdownButtonFormField(
              hint: Text(
                hintText,
                style: TextStyle(color: Colors.black.withOpacity(0.3)),
              ),
              dropdownColor: backgroundColor,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item.toString().split('.').last),
                );
              }).toList(),
              onChanged: (newValue) => {selectedValue.value = newValue!},
            ),
          ),
        ],
      ),
    );
  }
}
