import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/layout/app_assets.dart';
import 'package:theme/layout/app_config.dart';

class ImageInput extends StatelessWidget {
  final Function ontapIcon;
  final String placeHolderPath;

  ImageInput(
      {required this.ontapIcon, required this.placeHolderPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      strokeAlign: StrokeAlign.outside,
                      width: 2,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: AppColors.editTextColor,
                  child: SvgPicture.asset(
                    color: AppColors.hintTextColor,
                    placeHolderPath,
                    width: 110,
                    height: 110,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 110,
              bottom: 1,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      strokeAlign: StrokeAlign.outside,
                      width: 1,
                      color: AppColors.white,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.buttonColor,
                    child: IconButton(
                      icon: const Icon(
                        color: AppColors.white,
                        Icons.add_a_photo_outlined,
                        size: 25.0,
                      ),
                      onPressed: () {
                        ontapIcon;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
