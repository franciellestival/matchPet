import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:theme/export_theme.dart';
import 'package:theme/layout/app_assets.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 131,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: 0,
        selectedItemColor: AppColors.buttonColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.pawIcon,
              height: 30,
            ),
            label: 'oi',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.heartIcon,
              height: 30,
            ),
            label: 'oi',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvgs.appIcon),
            label: 'oi',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.disappearedIcon,
              height: 30,
            ),
            label: 'oi',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.userIcon,
              height: 30,
            ),
            label: 'oi',
          ),
        ],
      ),
    );
  }
}
