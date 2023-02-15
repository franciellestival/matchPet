import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_filter_controller.dart';
import 'package:theme/export_theme.dart';

class PetFilter extends GetView<FilterController> {
  const PetFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FilterController());
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
                          selected: controller.dogSelected.value,
                          onPressed: () => controller.dogSelected.toggle(),
                          label: 'Cão'),
                      _buildFilterButton(
                          icon: AppSvgs.catIcon,
                          selected: controller.catSelected.value,
                          onPressed: () => controller.catSelected.toggle(),
                          label: 'Gato'),
                      _buildFilterButton(
                          icon: AppSvgs.animalsIcon,
                          onPressed: () => controller.otherSelected.toggle(),
                          selected: controller.otherSelected.value,
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
                          onPressed: () => controller.maleSelected.toggle(),
                          selected: controller.maleSelected.value,
                          label: 'Macho'),
                      _buildFilterButton(
                          icon: AppSvgs.femaleIcon,
                          selected: controller.femaleSelected.value,
                          onPressed: () => controller.femaleSelected.toggle(),
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
                          selected: controller.smallSelected.value,
                          onPressed: () => controller.smallSelected.toggle(),
                          label: 'Pequeno'),
                      _buildFilterButton(
                          icon: AppSvgs.sizeM,
                          selected: controller.mediumSelected.value,
                          onPressed: () => controller.mediumSelected.toggle(),
                          label: 'Médio'),
                      _buildFilterButton(
                          icon: AppSvgs.sizeG,
                          selected: controller.bigSelected.value,
                          onPressed: () => controller.bigSelected.toggle(),
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
                          selected: controller.specialNeedYesSelected.value,
                          onPressed: () =>
                              controller.specialNeedYesSelected.toggle(),
                          label: 'Sim'),
                      _buildFilterButton(
                          icon: AppSvgs.close,
                          selected: controller.specialNeedNoSelected.value,
                          onPressed: () =>
                              controller.specialNeedNoSelected.toggle(),
                          label: 'Não'),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      Column(
        children: [
          const HeightSpacer(height: 5),
          const Text(
            'Idade',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Obx(() => Text(
                'Entre ${controller.ageStart.toString()} e  ${controller.ageEnd.toString()} anos',
              )),
          Obx(
            () => RangeSlider(
              activeColor: AppColors.buttonColor,
              inactiveColor: Colors.orange.shade100,
              labels: RangeLabels(
                  controller.ageStart.toString(), controller.ageEnd.toString()),
              values: RangeValues(
                  controller.ageStart.toDouble(), controller.ageEnd.toDouble()),
              onChanged: (RangeValues values) {
                controller.ageStart = values.start.toInt();
                controller.ageEnd = values.end.toInt();
              },
              min: 0.0,
              max: 15.0,
              divisions: 15,
            ),
          ),
        ],
      ),
      Column(
        children: [
          const Text(
            'Distância',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Obx(() => Text(
                'Até ${controller.distanceSlider.toInt().toString()} km',
              )),
          Obx(
            () => Slider(
              label: controller.distanceSlider.toString(),
              activeColor: AppColors.buttonColor,
              inactiveColor: Colors.orange.shade100,
              value: controller.distanceSlider.toDouble(),
              onChanged: ((double value) {
                controller.distanceSlider = value.toInt();
              }),
              min: 1.0,
              max: 100.0,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Center(
          child: PrimaryButton(
              height: 50,
              onTap: () => Future.sync(() async {
                    controller.isLoading.value = true;
                    var mappedFilters = await controller.getQueryMap();
                    controller.isLoading.value = false;
                    Get.back();
                    Get.toNamed(Routes.searchResultPage,
                        arguments: mappedFilters);
                  }),
              isLoading: controller.isLoading,
              text: 'Filtrar'),
        ),
      ),
    ];
  }
}
