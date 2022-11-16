import 'package:flutter/material.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/model/pet_profile.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';

class PetListPage extends StatefulWidget {
  final String listTitle = 'Todos disponíveis';

  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<PetProfile> profilesList = [];
  List<PetCard> petCardsList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<PetCard>> _getPetsList() async {
    return await PetController.getAllPets();
  }

  @override
  Widget build(BuildContext context) {
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
              child: const Center(
                  child: Text('Aqui uma barra de pesquisa futuramente')),
            ),
            FutureBuilder<List<PetCard>?>(
              future: _getPetsList(),
              builder: (context, snapshot) {
                return PetList(
                  title: widget.listTitle,
                  children: snapshot.hasData ? snapshot.data! : [],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
