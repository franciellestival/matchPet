import 'package:flutter/material.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';

class PetListPage extends StatefulWidget {
  final String listTitle;
  final List<PetCard> petList;
  final VoidCallback? onTapCallTapAction;

  PetListPage({
    super.key,
    required this.petList,
    this.listTitle = 'Todos disponíveis',
    this.onTapCallTapAction,
  });

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  static const image =
      'https://conteudo.imguol.com.br/c/entretenimento/54/2020/04/28/cachorro-pug-1588098472110_v2_1x1.jpg';

  PetProfile pet = PetProfile(
      name: 'Bobzinho', image: image, location: 'Curitiba', idade: '2 anos');
  PetProfile pet2 = PetProfile(
      name: 'Major',
      image: image,
      location: 'Fazenda Rio Grande',
      idade: '10 anos');
  PetProfile pet3 = PetProfile(
      name: 'Kite', image: image, location: 'Canada', idade: '7 anos');
  PetProfile pet4 = PetProfile(
      name: 'Laika', image: image, location: 'Curitiba', idade: '2 anos');
  PetProfile pet5 = PetProfile(
      name: 'Ruby', image: image, location: 'Curitiba', idade: '10 meses');

  @override
  Widget build(BuildContext context) {
    List<PetCard> petList2 = [
      PetCard(pet: pet),
      PetCard(pet: pet2),
      PetCard(pet: pet3),
      PetCard(pet: pet4),
      PetCard(pet: pet5),
    ];

    return Scaffold(
      appBar: GenericAppBar(title: widget.listTitle),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSpacer(),
            Container(
              color: AppColors.white,
              height: 50,
              width: 500,
              child: Center(
                  child: const Text('Aqui uma barra de pesquisa futuramente')),
            ),
            PetList(
              title: widget.listTitle,
              onTapCallTapAction: () => {},
              children: petList2,
            ),
          ],
        ),
      ),
    );
  }
}
