import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';

import 'package:theme/export_theme.dart';

class PetDetailPage extends StatelessWidget {
  Rx<bool> isFavorited = false.obs;
  bool? isMyPet;

  PetDetailPage({super.key, this.isMyPet = false});

  late PetProfile? pet;

  @override
  Widget build(BuildContext context) {
    pet = Get.arguments;

    return Scaffold(
      appBar: const GenericAppBar(title: 'Detalhes do Pet'),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpacer(),
            Container(
              height: 400,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(pet!.photoUrl!),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: isMyPet! ? editIcon() : favoriteIcon(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                '${pet?.name!} , ${pet?.breed}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      AppSvgs.locationIcon,
                      height: 15,
                      width: 15,
                    ),
                  ),
                  const Text(
                    'Curitiba/PR',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const HeightSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCardInfo('Sexo', pet!.gender!.displayName!),
                buildCardInfo('Idade', '${pet!.age.toString()} anos'),
                buildCardInfo('Peso', '${pet!.weight.toString()} kg'),
                buildCardInfo('Porte', pet!.size!.displayName!),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                pet!.description!,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Necessidades Especiais? ${pet!.specialNeeds! ? "Sim" : "Nenhuma"}',
              ),
            ),
            const HeightSpacer(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Ink(
                  decoration: ShapeDecoration(
                      shadows: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.blueButton),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(AppSvgs.zapIcon,
                        color: AppColors.white),
                  ),
                ),
                PrimaryButton(
                  height: 50,
                  onTap: () {},
                  text: 'Quero Adotar',
                  backgroundColor: AppColors.blueButton,
                ),
              ],
            ),
            const HeightSpacer(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                PrimaryButton(
                  height: 50,
                  onTap: () {
                    Get.toNamed(Routes.petProfilePage, arguments: pet);
                  },
                  text: 'Editar Pet',
                  backgroundColor: AppColors.blueButton,
                ),
              ],
            ),
            const HeightSpacer(height: 40),
          ],
        ),
      ),
    );
  }

  Widget favoriteIcon() {
    return GestureDetector(
      onTap: _onTapFavorite,
      child: CircleAvatar(
        backgroundColor: AppColors.white.withOpacity(0.5),
        child: Obx(() {
          return SvgPicture.asset(
            isFavorited.value ? AppSvgs.heartIcon : AppSvgs.favoriteOutlined,
            height: 24.0,
            color: isFavorited.value ? Colors.red : Colors.black,
          );
        }),
      ),
    );
  }

  Widget buildCardInfo(String title, String petInfo) {
    return Ink(
      decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.primaryColor),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              Text(
                petInfo,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTapFavorite() {
    PetController controller = PetController();

    isFavorited.value
        ? {controller.removeFromFavorites(), isFavorited.value = false}
        : {controller.addToFavorites(), isFavorited.value = true};
  }

  Widget editIcon() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.petEditPage, arguments: pet);
      },
      child: CircleAvatar(
        backgroundColor: AppColors.white.withOpacity(0.5),
        child: Obx(() {
          return SvgPicture.asset(
            AppSvgs.menuIcon,
            height: 24.0,
            color: isFavorited.value ? Colors.red : Colors.black,
          );
        }),
      ),
    );
  }
}
