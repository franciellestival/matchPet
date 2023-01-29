import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:theme/export_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_profile/controller/interest_controller.dart';
import 'package:user_profile/model/interest.dart';
import 'package:user_profile/pages/wanted_pets.dart';

class AdoptionInfo extends GetView<InterestController> {
  final bool isMyWantedPets;
  final Interest adoptionModel;

  const AdoptionInfo(
      {super.key, bool? isMyWantedPets, required this.adoptionModel})
      : isMyWantedPets = isMyWantedPets ?? false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          shadows: [
            const BoxShadow(
              color: AppColors.buttonColor,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: isMyWantedPets
            ? ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppSvgs.housePet,
                    height: 40,
                    width: 40,
                  ),
                ),
                title: Text(
                    'Quero adotar ${adoptionModel.pet?.name ?? 'Pet sem Nome'} '),
                subtitle: Text(
                    '${adoptionModel.pet?.owner?.name ?? 'Dono sem Nome'} recebeu uma notificação para avaliar a adoção'),
                trailing: TextButton(
                  onPressed: () {
                    _modalMyWantedPetDetails(context);
                  },
                  child: const Text(
                    'Detalhes',
                    style: TextStyle(
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              )
            : ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppSvgs.checkAdopters,
                    height: 40,
                    width: 40,
                  ),
                ),
                title:
                    Text('${adoptionModel.interestedUser?.name ?? 'Fulano'} '),
                subtitle: Text(
                    'quer adotar ${adoptionModel.pet?.name ?? 'sem Nome'}'),
                trailing: TextButton(
                  onPressed: () {
                    _modalAuthorizeContact(context);
                  },
                  child: adoptionModel.accepted ?? false
                      ? const Text(
                          'Contato liberado',
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      : const Text(
                          'Avaliar',
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                ),
              ),
      ),
    );
  }

  void _modalAuthorizeContact(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            height: MediaQuery.of(context).size.height * 0.30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: adoptionModel.accepted ?? false
                  ? getAuthorizedContactWidget()
                  : getunAuthorizedContactWidget(),
            ),
          ),
        );
      },
    );
  }

  void _modalMyWantedPetDetails(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            height: MediaQuery.of(context).size.height * 0.40,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: adoptionModel.accepted ?? false
                    ? getAuthorizedContactMyWantedPetsWidget()
                    : getunAuthorizedMyWantedPetsWidget()),
          ),
        );
      },
    );
  }

  Future<void> openWhatsApp() async {
    String phone =
        adoptionModel.pet?.owner?.phone?.replaceAll(RegExp(r'[^\d]'), '') ?? '';
    String message = 'Olá, ${adoptionModel.pet?.owner?.name ?? ''}.';
    String scheme = Platform.isAndroid ? 'https' : 'whatsapp';
    Uri waUri = Uri(
      scheme: scheme,
      host: 'wa.me',
      path: 'send',
      queryParameters: {
        'phone': '55$phone',
        'text': message,
      },
    );

    if (await canLaunchUrl(waUri)) {
      await launchUrl(waUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch';
    }
  }

  Widget getAuthorizedContactWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${adoptionModel.interestedUser?.name ?? 'Sem nome'} vai adotar ${adoptionModel.pet?.name ?? 'Sem nome'} ?',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Você pode ir até o perfil do pet e confirmar a adoção, ou retirar a permissão para que ${adoptionModel.interestedUser?.name ?? 'Sem nome'} não tenha mais acesso ao seu número de telefone',
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
          onPressed: () {
            controller.updateInterest(adoptionModel);
          },
          child: const Text(
            'Retirar permissão de contato',
            style: TextStyle(
                backgroundColor: AppColors.primaryLightColor,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.petDetailPage, arguments: adoptionModel.pet);
          },
          child: const Text(
            'Confirmar adoção',
            style: TextStyle(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget getunAuthorizedContactWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Antes de confirmar a adoção do pet, que tal trocar uma ideia com ${adoptionModel.interestedUser?.name ?? 'Sem nome'} ?',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Após a liberação, ${adoptionModel.interestedUser?.name ?? 'Sem nome'} poderá visualizar seu número de telefone, e os detalhes da adoção poderão ser combinados',
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                await controller.updateInterest(adoptionModel);
              },
              child: const Text(
                'Liberar contato',
                style: TextStyle(
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () async {
                await controller.removeInterest(adoptionModel);
              },
              child: const Text(
                'Recusar',
                style: TextStyle(
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getAuthorizedContactMyWantedPetsWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${adoptionModel.pet?.owner?.name ?? 'Sem nome'} autorizou que você entre em contato',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Ink(
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
                borderRadius: BorderRadius.circular(80),
              ),
              color: AppColors.buttonColor),
          child: IconButton(
            onPressed: () async {
              await openWhatsApp();
            },
            icon: SvgPicture.asset(AppSvgs.zapIcon, color: AppColors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Essa etapa é importante para entender se ${adoptionModel.pet?.name} se encaixa no seu estilo de vida',
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
          onPressed: () {
            controller.removeInterest(adoptionModel);
          },
          child: const Text(
            'Retirar interesse',
            style: TextStyle(
                backgroundColor: AppColors.primaryLightColor,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.petDetailPage, arguments: adoptionModel.pet);
          },
          child: const Text(
            'Ir para o perfil do pet',
            style: TextStyle(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget getunAuthorizedMyWantedPetsWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${adoptionModel.pet?.owner?.name ?? 'Sem nome'} ainda não autorizou a liberação de contato',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Aguarde a liberação, para que você possa saber mais detalhes sobre ${adoptionModel.pet?.name} ',
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                try {
                  await controller.removeInterest(adoptionModel);

                  Get.defaultDialog(
                      title: "Interesse removido",
                      middleText:
                          "${adoptionModel.pet?.name} não estará mais na sua lista de interesses",
                      backgroundColor: AppColors.primaryLightColor,
                      buttonColor: AppColors.buttonColor);
                } catch (e) {
                  Get.snackbar('Erro', 'Não foi possível remover interesse');
                }
              },
              child: const Text(
                'Retirar Interesse',
                style: TextStyle(
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Ir para o perfil do pet',
                style: TextStyle(
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
