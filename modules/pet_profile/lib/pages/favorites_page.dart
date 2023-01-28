import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/model/user.dart';

import '../controller/favorites_controller.dart';
import '../widgets/pet_card.dart';
import '../widgets/pet_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  Future<List<PetCard>?> _getPetsList() async {
    try {
      User loggedInUser = Get.find<User>(tag: "loggedInUser");
      return await FavoritesController.getFavorites(loggedInUser.id!);
    } catch (e) {
      Get.snackbar(
          'Erro!', "Não foi possivel obter a lista de Pets Favoritos.");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: "Pets Favoritos"),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSpacer(),
            FutureBuilder<List<PetCard>?>(
              future: _getPetsList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isEmpty
                      ? Center(
                          child: Column(
                            children: const [
                              Text(
                                'Você ainda não favoritou nenhum pet!',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        )
                      : PetList(
                          title: "Pets Favoritos", children: snapshot.data!);
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
}
