import 'package:flutter/material.dart';

import 'package:theme/export_theme.dart';

class PetList extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final String? titleCallToAction;

  const PetList(
      {super.key, required this.children, this.title, this.titleCallToAction});

  @override
  Widget build(BuildContext context) {
    return buidList(list: this, context: context);
  }

  Widget buidList({required PetList list, context}) {
    List<Widget> items = list.children.sublist(0);

    return Container(
      color: AppColors.primaryLightColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            children: [
              GridView.count(
                padding: const EdgeInsets.only(top: 16),
                crossAxisSpacing: 4,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 180 / 250,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: items.map((gridItem) {
                  return Padding(
                      padding: const EdgeInsets.all(2), child: gridItem);
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
