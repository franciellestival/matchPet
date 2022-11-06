import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/layout/app_config.dart';

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
