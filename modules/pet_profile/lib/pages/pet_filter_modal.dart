import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:theme/export_theme.dart';

class PetFilter extends StatelessWidget {
  PetFilter({super.key});

  var ageStartValue = 0.0.obs;
  var distanceStartValue = 10.0.obs;
  var ageEndValue = 10.0.obs;
  var distanceEndValue = 70.0.obs;

  var dogSelected = false.obs;
  var catSelected = false.obs;
  var otherSelected = false.obs;

  var maleSelected = false.obs;
  var femaleSelected = false.obs;

  var smallSelected = false.obs;
  var mediumSelected = false.obs;
  var bigSelected = false.obs;

  var noSpecialNeedsSelected = false.obs;
  var specialNeedsSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildFilters(),
    );
  }

  Widget _buildFilterButton(
      {required String icon,
      String? label,
      required bool selected,
      required Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Ink(
            decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: selected
                        ? AppColors.buttonColor.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColors.primaryColor),
            child: IconButton(
              icon: SvgPicture.asset(
                icon,
                height: 70,
                width: 70,
                color: selected ? AppColors.buttonColor : AppColors.black,
              ),
              onPressed: onPressed,
            ),
          ),
          Text(
            label ?? '',
            style: TextStyle(
                color: selected ? AppColors.buttonColor : AppColors.black),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilters() {
    return [
      Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Filtros',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      }),
      const HeightSpacer(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                const Text(
                  'Espécie',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton(
                          icon: AppSvgs.dogIcon,
                          selected: dogSelected.value,
                          onPressed: () => dogSelected.toggle(),
                          label: 'Cão'),
                      _buildFilterButton(
                          icon: AppSvgs.catIcon,
                          selected: catSelected.value,
                          onPressed: () => catSelected.toggle(),
                          label: 'Gato'),
                      _buildFilterButton(
                          icon: AppSvgs.animalsIcon,
                          onPressed: () => otherSelected.toggle(),
                          selected: otherSelected.value,
                          label: 'Outro'),
                    ],
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                const Text(
                  'Sexo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton(
                          icon: AppSvgs.maleIcon,
                          onPressed: () => maleSelected.toggle(),
                          selected: maleSelected.value,
                          label: 'Macho'),
                      _buildFilterButton(
                          icon: AppSvgs.femaleIcon,
                          selected: femaleSelected.value,
                          onPressed: () => femaleSelected.toggle(),
                          label: 'Fêmea'),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Porte',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton(
                          icon: AppSvgs.sizeP,
                          selected: smallSelected.value,
                          onPressed: () => smallSelected.toggle(),
                          label: 'Pequeno'),
                      _buildFilterButton(
                          icon: AppSvgs.sizeM,
                          selected: mediumSelected.value,
                          onPressed: () => mediumSelected.toggle(),
                          label: 'Médio'),
                      _buildFilterButton(
                          icon: AppSvgs.sizeG,
                          selected: bigSelected.value,
                          onPressed: () => bigSelected.toggle(),
                          label: 'Grande'),
                    ],
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Necessidades \n Especiais',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton(
                          icon: AppSvgs.check,
                          selected: noSpecialNeedsSelected.value,
                          onPressed: () => noSpecialNeedsSelected.toggle(),
                          label: 'Sim'),
                      _buildFilterButton(
                          icon: AppSvgs.close,
                          selected: specialNeedsSelected.value,
                          onPressed: () => specialNeedsSelected.toggle(),
                          label: 'Não'),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      StatefulBuilder(
        builder: (context, state) {
          return Column(
            children: [
              const HeightSpacer(height: 5),
              const Text(
                'Idade',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Entre ${ageStartValue.round().toString()} e  ${ageEndValue.round().toString()} anos',
              ),
              RangeSlider(
                min: 0.0,
                max: 10.0,
                divisions: 10,
                labels: RangeLabels(
                  ageStartValue.round().toString(),
                  ageEndValue.round().toString(),
                ),
                activeColor: AppColors.buttonColor,
                inactiveColor: Colors.orange.shade100,
                values: RangeValues(ageStartValue.value, ageEndValue.value),
                onChanged: (values) {
                  state(
                    () {
                      ageStartValue.value = values.start;
                      ageEndValue.value = values.end;
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
      StatefulBuilder(
        builder: (context, state) {
          return Column(
            children: [
              const Text(
                'Distância',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Entre ${distanceStartValue.round().toString()} e  ${distanceEndValue.round().toString()} km',
              ),
              RangeSlider(
                min: 0.0,
                max: 100.0,
                divisions: 10,
                labels: RangeLabels(
                  distanceStartValue.round().toString(),
                  distanceEndValue.round().toString(),
                ),
                activeColor: AppColors.buttonColor,
                inactiveColor: Colors.orange.shade100,
                values: RangeValues(
                    distanceStartValue.value, distanceEndValue.value),
                onChanged: (values) {
                  state(
                    () {
                      distanceStartValue.value = values.start;
                      distanceEndValue.value = values.end;
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Center(
            child: PrimaryButton(height: 50, onTap: () {}, text: 'Filtrar')),
      )
    ];
  }
}
