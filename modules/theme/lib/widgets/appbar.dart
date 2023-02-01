import 'package:flutter/material.dart';
import 'package:theme/layout/app_config.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor = AppColors.buttonColor;
  final String title;
  final bool? showBackArrow;
  final AppBar? appBar;

  const GenericAppBar(
      {Key? key, required this.title, this.showBackArrow, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackArrow ?? true,
      title: Text(title),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
