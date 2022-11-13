import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme/layout/app_config.dart';

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
  final Rx<String> selectedValue = ''.obs;

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
