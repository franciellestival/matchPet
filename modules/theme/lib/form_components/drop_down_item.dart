import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../layout/app_config.dart';

class DropDownItem extends StatefulWidget {
  final Rx<String> currentValue;
  final String hintText;
  final List<String?> items;
  final Rx<bool> isEnabled;

  const DropDownItem(
      {Key? key,
      required this.hintText,
      required this.currentValue,
      required this.items,
      required this.isEnabled})
      : super(key: key);

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppRadius.buttonRadius)),
            borderSide: const BorderSide(color: AppColors.buttonColor),
          ),
          label: Text.rich(TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Text(
              widget.hintText,
              style: const TextStyle(color: Colors.black),
            ))
          ]))),
      dropdownColor: AppColors.editTextColor,
      items: widget.items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
      value: widget.currentValue.value.isEmpty
          ? widget.items.first
          : widget.currentValue.value.toString(),
      onChanged: !widget.isEnabled.value
          ? null
          : (newValue) =>
              setState(() => widget.currentValue.value = newValue.toString()),
    );
  }
}
