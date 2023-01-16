import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/pages/pet_filter_modal.dart';
import 'package:pet_profile/pages/pet_search_bar.dart';

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

  Future<List<PetCard>?> _getPetsList() async {
    try {
      return await PetController.getAllPets();
    } catch (e) {
      // Get.snackbar('Erro!', e.toString());
      Get.snackbar('Erro!', "Não foi possivel obter a lista de Animais.");
    }
    return null;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PetSearchBar(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _modalBottomSheetConfig(context);
                  },
                  icon: SvgPicture.asset(
                    AppSvgs.filterIcon,
                  ),
                ),
              ],
            ),
            FutureBuilder<List<PetCard>?>(
              future: _getPetsList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PetList(
                      title: widget.listTitle, children: snapshot.data!);
                } else {
                  if (snapshot.hasError) {
                    Get.snackbar('Error', snapshot.error.toString());
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.buttonColor));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetConfig(context) {
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
            height: MediaQuery.of(context).size.height * 0.85,
            child: PetFilter(),
          ),
        );
      },
    );
  }
}
