import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/favorites_controller.dart';
import 'package:user_profile/controller/interest_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';

import 'package:theme/export_theme.dart';
import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/interest.dart';
import 'package:user_profile/model/user.dart';

import '../controller/pet_controller.dart';
import '../widgets/dialog_links.dart';

class PetDetailPage extends StatelessWidget {
  final RxBool isFavorited = false.obs;
  final RxBool hasInterest = false.obs;

  PetDetailPage({super.key});

  PetProfile? pet;
  User? loggedInUser;

  @override
  Widget build(BuildContext context) {
    loggedInUser = Get.find<User>(tag: "loggedInUser");
    pet = Get.arguments;
    isFavorited.value = pet!.isUserFavorite!;
    bool isMyPet = (pet!.owner!.id == loggedInUser!.id!);

    InterestController interestController = Get.put(InterestController());
    Future.sync(() async {
      await interestController.getInterestByPet(pet!.id!);
      hasInterest.value = false;
      if (interestController.userList.isNotEmpty) {
        hasInterest.value = true;
      }
    });

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '${pet?.name ?? 'Sem Nome'}  , ${pet?.breed ?? 'Sem Raça'}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
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
                    ? Column(
                        children: [
                          PrimaryButton(
                            backgroundColor:
                                pet!.status!.normalizedName != "missing"
                                    ? AppColors.blueButton
                                    : Colors.grey.withOpacity(0.5),
                            onTap: pet!.status!.normalizedName != "missing"
                                ? () => {_setMissingPet(pet)}
                                : () => {_setFoundPet(pet)},
                            text: pet!.status!.normalizedName != "missing"
                                ? "Marcar como Desaparecido"
                                : "Marcar como Disponível",
                          ),
                          PrimaryButton(
                            height: 50,
                            onTap: () {
                              // _showDialogMessage(context, true, true);
                              _showAdoptionConfirmationDialog();
                            },
                            text: 'Confirmar adoção',
                            backgroundColor: AppColors.blueButton,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          PrimaryButton(
                            height: 50,
                            onTap: () {
                              _showInterestDialog(loggedInUser!.id!, pet!.id!);
                            },
                            text: 'Quero Adotar',
                            backgroundColor: AppColors.blueButton,
                          ),
                          if (pet!.status!.normalizedName == "missing")
                            PrimaryButton(
                              height: 50,
                              onTap: () => {
                                UserController.openWhatsApp(pet!,
                                    adoption: false)
                              },
                              text: 'Entrar em contato',
                              backgroundColor: AppColors.blueButton,
                            ),
                        ],
                      ),
              )
            ],
          ),
        ));
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

  void _showInterestDialog(int userId, int petId) async {
    try {
      InterestController controller = Get.find<InterestController>();
      await controller.saveInterest(userId, petId);
      Get.dialog(
        AlertDialog(
          title: Text('Quero adotar ${pet?.name ?? ''} '),
          content: const Text(
              'O tutor do pet foi notificado sobre seu interesse. Logo você poderá contatá-lo.'),
          actions: [
            const GoHomeDialogLink(),
            GoBackDialogLink(onPressed: () => Get.back()),
          ],
        ),
      );
    } catch (e) {
      Get.snackbar("Erro!", "Erro ao notificar interesse no Pet.");
    }
  }

  void _showAdoptionConfirmationDialog() async {
    InterestController interestController = Get.find<InterestController>();

    if (!hasInterest.value) {
      Get.defaultDialog(
        title: "Ops!",
        middleText: "O pet ${pet!.name} não possui nenhum usuário interessado!",
        backgroundColor: AppColors.primaryLightColor,
        buttonColor: AppColors.buttonColor,
      );
      return;
    }

    AlertDialog adoptionConfirmationDialog = AlertDialog(
      title: Text('Confirmar a adoção de ${pet?.name ?? ''}?'),
      actions: [
        ConfirmAdoptionLink(onPressed: _confirmAdoptionFunction),
        GoBackDialogLink(onPressed: () => Get.back())
      ],
      content: SizedBox(
        height: 110,
        child: Column(
          children: [
            const Text('Escolha o novo tutor:'),
            const HeightSpacer(height: 20),
            FutureBuilder<List<Interest>>(
                future: interestController.getInterestByPet(pet!.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return FormDropDownInput(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppRadius.buttonRadius)),
                            borderSide:
                                const BorderSide(color: AppColors.buttonColor),
                          ),
                          label: const Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                    child: Text(
                                  'Usuário',
                                  style: TextStyle(color: Colors.black),
                                ))
                              ],
                            ),
                          ),
                        ),
                        dropdownColor: AppColors.editTextColor,
                        // value: interestController.interestedUser,
                        items: data
                            .map((interest) => DropdownMenuItem<int>(
                                  value: interest.interestedUser!.id,
                                  child: Text(interest.interestedUser!.name!),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          interestController.interestedUserId = newValue!;
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );

    Get.dialog(adoptionConfirmationDialog);
  }

  void _confirmAdoptionFunction() async {
    InterestController interestController = Get.find<InterestController>();

    var interestedUserId = interestController.interestedUserId;
    debugPrint(
        "USUARIO.ID INTERESSADO: ${interestController.interestedUserId.toString()}");

    try {
      await PetController.changeAdoptionStatus(interestedUserId, pet!.id!);
      Get.back();
      Get.dialog(
        AlertDialog(
          title: const Text("Tudo certo!"),
          content: Text("Adoção do pet ${pet!.name} confirmada!"),
          backgroundColor: AppColors.primaryLightColor,
          actions: [GoBackDialogLink(onPressed: () => Get.back())],
        ),
      );
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível confirmar adoção do pet.');
    }
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

  Widget _buttonConfirmAdoption(PetProfile? pet) {
    return Obx(() => PrimaryButton(
          height: 50,
          onTap: () {
            hasInterest.value ? _showAdoptionConfirmationDialog() : null;
          },
          text: 'Confirmar adoção',
          backgroundColor: AppColors.blueButton,
          disabledColor: Colors.grey.withOpacity(0.5),
        ));
  }

  void _setMissingPet(PetProfile? pet) {
    if (pet != null) {
      Get.dialog(AlertDialog(
        title: const Text("Atenção!"),
        content: const Text("Deseja realmente marcar o pet como desaparecido?"),
        actions: [
          GoBackDialogLink(
              onPressed: () => {
                    Future.sync(() async {
                      try {
                        await PetController.changeMissingStatus(pet.id!);
                        Get.back();
                        Get.defaultDialog(
                            title: "Ok!",
                            middleText:
                                "Seu pet foi marcado como Desaparecido. Esperamos que o encontre logo!",
                            backgroundColor: AppColors.primaryLightColor,
                            buttonColor: AppColors.buttonColor,
                            confirmTextColor: AppColors.black,
                            onConfirm: () => Get.back());
                      } catch (e) {
                        Get.snackbar("Erro!", e.toString(),
                            duration: const Duration(seconds: 5));
                      }
                    })
                  }),
          GoBackDialogLink(onPressed: () {
            // Get.closeCurrentSnackbar();
            Get.back();
          })
        ],
        backgroundColor: AppColors.primaryLightColor,
      ));
    }
  }

  void _setFoundPet(PetProfile? pet) {
    if (pet != null) {
      Get.dialog(AlertDialog(
        title: const Text("!"),
        content: const Text("Seu pet foi encontrado?"),
        actions: [
          GoBackDialogLink(
              onPressed: () => {
                    Future.sync(() async {
                      try {
                        await PetController.changeMissingStatus(pet.id!,
                            found: true);
                        Get.back();
                        Get.dialog(
                          AlertDialog(
                            title: const Text("Parabéns!"),
                            content: const Text(
                                "O status do seu pet foi alterado para disponível para adoção!"),
                            backgroundColor: AppColors.primaryLightColor,
                            actions: [
                              GoBackDialogLink(onPressed: () {
                                Get.back();
                              })
                            ],
                          ),
                        );
                      } catch (e) {
                        Get.snackbar("Erro!", e.toString(),
                            duration: const Duration(seconds: 5));
                      }
                    })
                  })
        ],

        backgroundColor: AppColors.primaryLightColor,

        // barrierDismissible: false,
      ));
    }
  }
}
