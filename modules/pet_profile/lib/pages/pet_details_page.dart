import 'package:flutter/material.dart';

import 'package:pet_profile/models/pet_profile.dart';

import 'package:theme/export_theme.dart';

class PetDetailPage extends StatelessWidget {
  PetProfile pet = PetProfile(
    id: 1,
    name: 'Kite Katiussa',
    species: Species.dog,
    gender: Gender.female,
    size: Size.medium,
    status: Status.available,
    breed: 'Husky Paraguaio',
    age: 7,
    weight: 30,
    description: 'Linda minha filha, não está pra adoção é só um teste',
    neutered: 1,
    specialNeeds: 1,
    photoUrl:
        'https://i.pinimg.com/originals/d8/9e/d9/d89ed96e3cda94aff64b574662a621b3.jpg',
    owner: null,
    location: null,
  );

  PetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(pet.photoUrl!),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: favoriteIcon(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                '${pet.name!} , ${pet.breed}',
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
                buildCardInfo('Sexo', pet.gender.toString().split('.').last),
                buildCardInfo('Idade', '${pet.age.toString()} anos'),
                buildCardInfo('Peso', '${pet.weight.toString()} kg'),
                buildCardInfo('Porte', pet.size.toString().split('.').last),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${pet.description!} ${pet.description!} ${pet.description!} ${pet.description!}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Necessidades Especiais? ${getSpecialNeedsText()}',
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
          ],
        ),
      ),
    );
  }

  Widget favoriteIcon() {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: AppColors.white.withOpacity(0.7),
        child: SvgPicture.asset(
          AppSvgs.heartIcon,
          height: 24.0,
          color: Colors.red,
        ),
      ),
    );
  }

  String getSpecialNeedsText() {
    String text = '';

    if (pet.specialNeeds == 1) {
      text = 'Nenhuma';
    } else {
      text = 'Sim';
    }
    return text;
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
}
