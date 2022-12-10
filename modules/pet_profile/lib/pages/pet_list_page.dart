import 'package:flutter/material.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';

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

  var _ageStartValue = 0.0;
  var _distanceStartValue = 10.0;
  var _ageEndValue = 10.0;
  var _distanceEndValue = 70.0;

  final _formKey = GlobalKey<FormState>();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSearchBar(_formKey),
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

  void _modalBottomSheetConfig(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          child: Wrap(
            children: _buildFilters(),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(GlobalKey<FormState> formKey) {
    TextEditingController inputSearch = TextEditingController();

    return FormInputBox(
      hintText: 'Pesquisa',
      controller: inputSearch,
      backgroundColor: AppColors.primaryColor,
      suffixIcon: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          AppSvgs.searchIcon,
          height: 20,
        ),
      ),
    );
  }

  Widget _buildFilterButton(
      {required String icon, required Function() onpressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(
        decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
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
          ),
          onPressed: onpressed,
        ),
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
              Navigator.pop(context);
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Espécie',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterButton(icon: AppSvgs.dogIcon, onpressed: () {}),
                    _buildFilterButton(icon: AppSvgs.catIcon, onpressed: () {}),
                  ],
                ),
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
                    'Sexo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterButton(
                        icon: AppSvgs.maleIcon, onpressed: () {}),
                    _buildFilterButton(
                        icon: AppSvgs.femaleIcon, onpressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      const HeightSpacer(height: 30),
      Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Idade',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StatefulBuilder(
            builder: (context, state) {
              return RangeSlider(
                min: 0.0,
                max: 10.0,
                divisions: 10,
                labels: RangeLabels(
                  _ageStartValue.round().toString(),
                  _ageEndValue.round().toString(),
                ),
                activeColor: AppColors.buttonColor,
                inactiveColor: Colors.orange.shade100,
                values: RangeValues(_ageStartValue, _ageEndValue),
                onChanged: (values) {
                  state(
                    () {
                      _ageStartValue = values.start;
                      _ageEndValue = values.end;
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      const HeightSpacer(height: 30),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Porte',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton(icon: AppSvgs.sizeP, onpressed: () {}),
                _buildFilterButton(icon: AppSvgs.sizeM, onpressed: () {}),
                _buildFilterButton(icon: AppSvgs.sizeG, onpressed: () {}),
              ],
            ),
          ],
        ),
      ),
      Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Distância',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StatefulBuilder(
            builder: (context, state) {
              return RangeSlider(
                min: 0.0,
                max: 100.0,
                divisions: 10,
                labels: RangeLabels(
                  _distanceStartValue.round().toString(),
                  _distanceEndValue.round().toString(),
                ),
                activeColor: AppColors.buttonColor,
                inactiveColor: Colors.orange.shade100,
                values: RangeValues(_distanceStartValue, _distanceEndValue),
                onChanged: (values) {
                  state(
                    () {
                      _distanceStartValue = values.start;
                      _distanceEndValue = values.end;
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      const HeightSpacer(height: 30),
      Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Necessidades Especiais',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFilterButton(icon: AppSvgs.check, onpressed: () {}),
              _buildFilterButton(icon: AppSvgs.close, onpressed: () {}),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: PrimaryButton(height: 50, onTap: () {}, text: 'Filtrar')),
      )
    ];
  }
}
