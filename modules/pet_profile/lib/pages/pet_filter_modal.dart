import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_filter_controller.dart';
import 'package:theme/export_theme.dart';

class PetFilter extends StatelessWidget {
  PetFilter({super.key});
  FilterController filterController = FilterController();

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
      Row(
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
      ),
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
                          selected: filterController.dogSelected.value,
                          onPressed: () =>
                              filterController.dogSelected.toggle(),
                          label: 'Cão'),
                      _buildFilterButton(
                          icon: AppSvgs.catIcon,
                          selected: filterController.catSelected.value,
                          onPressed: () =>
                              filterController.catSelected.toggle(),
                          label: 'Gato'),
                      _buildFilterButton(
                          icon: AppSvgs.animalsIcon,
                          onPressed: () =>
                              filterController.otherSelected.toggle(),
                          selected: filterController.otherSelected.value,
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
                          onPressed: () =>
                              filterController.maleSelected.toggle(),
                          selected: filterController.maleSelected.value,
                          label: 'Macho'),
                      _buildFilterButton(
                          icon: AppSvgs.femaleIcon,
                          selected: filterController.femaleSelected.value,
                          onPressed: () =>
                              filterController.femaleSelected.toggle(),
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
                          selected: filterController.smallSelected.value,
                          onPressed: () =>
                              filterController.smallSelected.toggle(),
                          label: 'Pequeno'),
                      _buildFilterButton(
                          icon: AppSvgs.sizeM,
                          selected: filterController.mediumSelected.value,
                          onPressed: () =>
                              filterController.mediumSelected.toggle(),
                          label: 'Médio'),
                      _buildFilterButton(
                          icon: AppSvgs.sizeG,
                          selected: filterController.bigSelected.value,
                          onPressed: () =>
                              filterController.bigSelected.toggle(),
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
                    style: TextStyle(fontSize: 1, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton(
                          icon: AppSvgs.check,
                          selected:
                              filterController.noSpecialNeedsSelected.value,
                          onPressed: () =>
                              filterController.noSpecialNeedsSelected.toggle(),
                          label: 'Sim'),
                      _buildFilterButton(
                          icon: AppSvgs.close,
                          selected: filterController.specialNeedsSelected.value,
                          onPressed: () =>
                              filterController.specialNeedsSelected.toggle(),
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
                'Entre ${filterController.ageStartValue.round().toString()} e  ${filterController.ageEndValue.round().toString()} anos',
              ),
              RangeSlider(
                min: 0.0,
                max: 10.0,
                divisions: 10,
                labels: RangeLabels(
                  filterController.ageStartValue.round().toString(),
                  filterController.ageEndValue.round().toString(),
                ),
                activeColor: AppColors.buttonColor,
                inactiveColor: Colors.orange.shade100,
                values: RangeValues(filterController.ageStartValue.value,
                    filterController.ageEndValue.value),
                onChanged: (values) {
                  state(
                    () {
                      filterController.ageStartValue.value = values.start;
                      filterController.ageEndValue.value = values.end;
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
                'Entre ${filterController.distanceStartValue.round().toString()} e  ${filterController.distanceEndValue.round().toString()} km',
              ),
              RangeSlider(
                min: 0.0,
                max: 100.0,
                divisions: 10,
                labels: RangeLabels(
                  filterController.distanceStartValue.round().toString(),
                  filterController.distanceEndValue.round().toString(),
                ),
                activeColor: AppColors.buttonColor,
                inactiveColor: Colors.orange.shade100,
                values: RangeValues(filterController.distanceStartValue.value,
                    filterController.distanceEndValue.value),
                onChanged: (values) {
                  state(
                    () {
                      filterController.distanceStartValue.value = values.start;
                      filterController.distanceEndValue.value = values.end;
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
