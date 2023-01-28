import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/export_theme.dart';
import 'package:theme/layout/app_assets.dart';
import 'package:user_profile/model/adoption.dart';

class AdoptionInfo extends StatelessWidget {
  final bool isMyWantedPets;
  final AdoptionModel adoptionModel;

  const AdoptionInfo(
      {super.key, this.isMyWantedPets = false, required this.adoptionModel});

  @override
  Widget build(BuildContext context) {
    return isMyWantedPets
        ? const ListTile()
        : Ink(
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
              child: ListTile(
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
                    _modalBottomSheetConfig(context);
                  },
                  child: adoptionModel.authorized ?? false
                      ? const Text(
                          'Liberar contato',
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
            height: MediaQuery.of(context).size.height * 0.50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('oi')],
              ),
            ),
          ),
        );
      },
    );
  }
}
