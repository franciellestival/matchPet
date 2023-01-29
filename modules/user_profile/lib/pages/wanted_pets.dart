import 'package:flutter/material.dart';

import 'package:pet_profile/models/pet_gender.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/models/pet_size.dart';
import 'package:pet_profile/models/pet_specie.dart';
import 'package:pet_profile/models/pet_status.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/model/interest.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/widgets/adoption_info.dart';

class WantedPets extends StatelessWidget {
  final bool isMyWantedPets;

  static User user = User(
    id: 32,
    name: "Luis Testes1",
    phone: "(41) 99988-7744",
    email: "luistestes1@gmail.com",
  );

  static User user2 = User(
    id: 12,
    name: "Fran Stival",
    phone: "(41) 99988-7744",
    email: "luistestes1@gmail.com",
  );

  WantedPets({super.key, required this.isMyWantedPets});

  static PetProfile pet2 = PetProfile(
      id: 9,
      name: "Kite Feliz",
      specie: PetSpecie(displayName: "cachorro"),
      gender: PetGender(displayName: "macho"),
      size: PetSize(displayName: "medium"),
      status: PetStatus(displayName: "registered"),
      breed: "vira lata",
      age: 3,
      weight: 4.3,
      description: "um dog bunito",
      neutered: false,
      specialNeeds: false,
      owner: user2,
      photoUrl:
          "https://conteudo.imguol.com.br/c/entretenimento/54/2020/04/28/cachorro-pug-1588098472110_v2_1x1.jpg");

  static PetProfile pet = PetProfile(
      id: 9,
      name: "Doguinho Feliz",
      specie: PetSpecie(displayName: "cachorro"),
      gender: PetGender(displayName: "macho"),
      size: PetSize(displayName: "medium"),
      status: PetStatus(displayName: "registered"),
      breed: "vira lata",
      age: 3,
      weight: 4.3,
      description: "um dog bunito",
      neutered: false,
      specialNeeds: false,
      owner: user,
      photoUrl:
          "https://conteudo.imguol.com.br/c/entretenimento/54/2020/04/28/cachorro-pug-1588098472110_v2_1x1.jpg");

  Interest info = Interest(
    interestedUser: user,
    pet: pet,
    accepted: false,
  );

  Interest info2 = Interest(
    interestedUser: user2,
    pet: pet2,
    accepted: true,
  );
  @override
  Widget build(BuildContext context) {
    List<Interest> adoptionInterestList = [info, info2, info];

    return Scaffold(
      appBar: GenericAppBar(
          title: isMyWantedPets ? 'Meus futuros Pets' : 'Avaliar interessados'),
      backgroundColor: AppColors.primaryColor.withOpacity(0.9),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView(
            children: adoptionInterestList.map((e) {
              return AdoptionInfo(
                  adoptionModel: e, isMyWantedPets: isMyWantedPets);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
