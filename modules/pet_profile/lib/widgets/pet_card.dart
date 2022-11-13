// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:theme/export_theme.dart';

class PetProfile {
  final String name;
  final String image;
  final String location;
  final String idade;

  PetProfile({
    required this.name,
    required this.image,
    required this.location,
    required this.idade,
  });
}

class PetCard extends StatelessWidget {
  final bool isFavorited;
  final Function? onTap;
  final Function? onTapFavorite;
  final PetProfile pet;

  PetCard({
    super.key,
    this.onTap,
    this.onTapFavorite,
    required this.pet,
    this.isFavorited = false,
  });

  @override
  Widget build(BuildContext context) {
    return cardScaffold(
        child: Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
      height: 258,
      decoration: cardBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              petImage(),
              favoriteIcon(),
            ],
          ),
          const SizedBox(height: 8),
          petInfo(context),
        ],
      ),
    ));
  }

  final BoxDecoration cardBoxDecoration = BoxDecoration(
    color: AppColors.primaryColor,
    borderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    border: Border.all(
      color: AppColors.black,
      width: 1,
    ),
  );

  Widget cardScaffold({
    required Widget child,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: <Widget>[
        GestureDetector(
          onTap: onTap as void Function()?,
          child: child,
        ),
      ],
    );
  }

  Widget petImage() {
    double size = 140.0;

    final image = pet.image;

    return SizedBox(
      width: size,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: image,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget petInfo(context, {Widget? favoriteButton}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        petName(),
        SizedBox(),
        Row(
          children: [
            petLocation(),
            petAge(),
          ],
        ),
      ],
    );
  }

  Widget petName() {
    return Text('${pet.name}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: themeData.textTheme.headline2);
  }

  Widget petLocation() {
    return Text('${pet.location}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: themeData.textTheme.bodyMedium);
  }

  Widget petAge() {
    return Text('${pet.idade}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: themeData.textTheme.bodyMedium);
  }

  Widget favoriteIcon() {
    return GestureDetector(
      onTap: onTapFavorite as void Function()?,
      child: SvgPicture.asset(
        isFavorited ? AppSvgs.heartIcon : AppSvgs.heartIcon,
        height: 24.0,
        color: AppColors.black,
      ),
    );
  }
}
