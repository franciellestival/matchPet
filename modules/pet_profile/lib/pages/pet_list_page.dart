import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:theme/export_theme.dart';
import 'package:theme/layout/app_config.dart';

class PetListPage extends StatefulWidget {
  final String listTitle;
  final List<PetProfile> petList;
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
      name: 'Tiruruzinho', image: image, location: 'Curitiba', idade: '2 anos');

  @override
  Widget build(BuildContext context) {
    List<PetProfile> petList2 = [];

    return Container(
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Container(
                child: SectionDivider(
                  title: widget.listTitle,
                  onTapCallToAction: () => {},
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                widget.petList.map(
                  (e) {
                  return Padding(padding: EdgeInsets.only(bottom: 16),
                  child: Obx(
                    () => PetCard(pet: e),
                  ),)
                }).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
