import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchpet_poc/routes/app_routes.dart';
import 'package:theme/components/button_component.dart';
import 'package:theme/layout/app_assets.dart';
import 'package:theme/layout/app_config.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      AppImages.initialPagePhoto,
                      fit: BoxFit.fill,
                      height: 450,
                      width: double.maxFinite,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 390),
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.cardRadius),
                            ),
                            color: AppColors.primaryColor),
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Pronto para encontrar um novo amigo?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'um textinho muito bonitinho cheio de pipipopopo pra deixar as pessoas felizes e empolgadas',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              onTap: () => {Get.toNamed(Routes.REGISTER)},
                              text: AppStrings.registerButton,
                              backgroundColor: AppColors.blueButton,
                              borderRadius: AppRadius.blueButtonRadius,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () => {Get.toNamed(Routes.LOGIN)},
                                child: const Text('Já tenho cadastro'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 340),
                      child: Center(
                        child: SvgPicture.asset(
                          AppSvgs.appIcon,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
