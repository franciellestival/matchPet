import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme/export_theme.dart';

import '../routes/app_routes.dart';

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
                                'Não perca a oportunidade de mudar a vida de um animal e de adicionar um novo membro amoroso à sua família. Comece sua busca hoje mesmo!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              onTap: () =>
                                  {Get.offAndToNamed(Routes.registerRoute)},
                              text: AppStrings.registerButton,
                              backgroundColor: AppColors.blueButton,
                              borderRadius: AppRadius.blueButtonRadius,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () =>
                                    {Get.offAndToNamed(Routes.loginRoute)},
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
