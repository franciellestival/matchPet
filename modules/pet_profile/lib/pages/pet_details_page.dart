import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/favorites_controller.dart';
import 'package:user_profile/controller/interest_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';

import 'package:theme/export_theme.dart';
import 'package:user_profile/model/user.dart';

class PetDetailPage extends StatelessWidget {
  final RxBool isFavorited = false.obs;

  PetDetailPage({super.key});

  late PetProfile? pet;

  @override
  Widget build(BuildContext context) {
    final User loggedInUser = Get.find<User>(tag: "loggedInUser");
    pet = Get.arguments;
    isFavorited.value = pet!.isUserFavorite!;
    bool isMyPet = (pet!.owner!.id == loggedInUser.id!);

    Get.put(InterestController());

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
                  image: NetworkImage(pet?.photoUrl ??
                      'https://i.pinimg.com/originals/d8/9e/d9/d89ed96e3cda94aff64b574662a621b3.jpg'),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: isMyPet ? editIcon() : favoriteIcon(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                '${pet?.name ?? 'Sem Nome'}  , ${pet?.breed ?? 'Sem Raça'}',
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
                buildCardInfo('Sexo', pet!.gender?.displayName ?? ''),
                buildCardInfo('Idade', '${pet!.age.toString()} anos'),
                buildCardInfo('Peso', '${pet!.weight.toString()} kg'),
                buildCardInfo('Porte', pet!.size?.displayName ?? ''),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                pet!.description ?? '',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Necessidades Especiais? ${pet!.specialNeeds ?? false ? "Sim" : "Nenhuma"}',
              ),
            ),
            const HeightSpacer(height: 40),
            Center(
              child: isMyPet
                  ? PrimaryButton(
                      height: 50,
                      onTap: () {
                        _showDialogMessage(context, true, true);
                      },
                      text: 'Confirmar adoção',
                      backgroundColor: AppColors.blueButton,
                    )
                  : PrimaryButton(
                      height: 50,
                      onTap: () {
                        _showDialogMessage(context, false, isMyPet);
                        // _showInterestDialog(
                        //   loggedInUser.id!,
                        //   pet!.id!,
                        // );
                      },
                      text: 'Quero Adotar',
                      backgroundColor: AppColors.blueButton,
                    ),
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

  void _onTapFavorite() async {
    try {
      final User loggedInUser = Get.find<User>(tag: "loggedInUser");

      if (isFavorited.value) {
        await FavoritesController.removeFromFavorites(
            loggedInUser.id!, pet!.id!);
        isFavorited.value = false;
      } else {
        await FavoritesController.addToFavorites(loggedInUser.id!, pet!.id!);
        isFavorited.value = true;
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
          'Erro!', 'Erro ao mudar o status de favorito do pet ${pet!.name}!');
    }
  }

  TextStyle buttonTextStyle() {
    return const TextStyle(
        color: AppColors.buttonColor,
        fontWeight: FontWeight.bold,
        fontSize: 15);
  }

  void _showDialogMessage(
      BuildContext context, bool success, bool confirmAdoption) {
    Widget goHomeButton = TextButton(
      onPressed: () {
        Get.offAndToNamed(Routes.home);
      },
      child: Text(
        'Ir para a Home',
        style: buttonTextStyle(),
      ),
    );

    Widget backButton = TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'Voltar',
        style: buttonTextStyle(),
      ),
    );

    Widget confirmAdoptionButton = TextButton(
      onPressed: () {},
      child: Text(
        'Confirmar Adoção',
        style: buttonTextStyle(),
      ),
    );

    AlertDialog adoptionAlert = AlertDialog(
      title: Text('Confirmar a adotação de ${pet?.name ?? ''}?'),
      content: SizedBox(
        height: 110,
        child: Column(
          children: [
            const Text('Quem vai ser o novo tutor?'),
            const HeightSpacer(height: 20),
            FormDropDownInput(
              child: DropDownItem(
                items: const ['lulis', 'fran', 'tom'],
                currentValue: 'lulis'.obs,
                hintText: 'Sexo',
                isEnabled: true.obs,
              ),
            ),
          ],
        ),
      ),
      actions: [confirmAdoptionButton, backButton],
    );

    AlertDialog notificationAlert = AlertDialog(
      title: Text('Quero adotar ${pet?.name ?? ''} '),
      content: Text(success
          ? 'O tutor do pet foi notificado sobre seu interesse. Logo você poderá contatá-lo'
          : 'Algo deu errado. Tente novamente mais tarde'),
      actions: [goHomeButton, backButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return confirmAdoption ? adoptionAlert : notificationAlert;
        });
  }

  // void _showInterestDialog(int userId, int petId) async {
  //   InterestController controller = Get.find<InterestController>();
  //   await controller.saveInterest(userId, petId);
  //   Get.dialog(
  //     AlertDialog(
  //       title: Text('Quero adotar ${pet?.name ?? ''} '),
  //       content: const Text(
  //           'O tutor do pet foi notificado sobre seu interesse. Logo você poderá contatá-lo.'),
  //       actions: const [GoHomeDialogLink(), GoBackDialogLink()],
  //     ),
  //   );
  // }

  // void _showAdoptionConfirmationDialog() async {
  //   InterestController interestController = Get.find<InterestController>();
  //   AlertDialog adoptionConfirmationDialog = AlertDialog(
  //     title: Text('Confirmar a adoção de ${pet?.name ?? ''}?'),
  //     content: SizedBox(
  //       height: 110,
  //       child: Column(
  //         children: [
  //           const Text('Escolha o novo tutor:'),
  //           const HeightSpacer(height: 20),
  //           FormDropDownInput(
  //             child: FutureBuilder<List<User>>(
  //             builder: (context, snapshot) {
  //               if (snapshot.hasData) {
  //                 var userList = snapshot.data!;
  //                 return DropDownItem(items: userList.map((e) => ), currentValue: interestController.interestedUser.value.name, hintText: "Adotante", isEnabled: true.obs,);
  //               }
  //               else {
  //                 if (snapshot.hasError) {
  //                   Get.snackbar('Erro!', 'Não foi possivel buscar a lista de interessados.');
  //                 }
  //               }
  //               return const CircularProgressIndicator();

  //             }
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  //   //await InterestController.getInterests(petId);
  // }

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
