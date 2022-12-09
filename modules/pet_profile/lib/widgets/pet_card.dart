// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:theme/export_theme.dart';

class PetCard extends StatelessWidget {
  final bool isFavorited;
  final Function? onTap;
  final Function? onTapFavorite;
  final PetProfile pet;

  const PetCard({
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
        height: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                AppColors.black.withOpacity(0.3), BlendMode.darken),
            fit: BoxFit.cover,
            image: NetworkImage(pet.photoUrl ??
                'https://i.pinimg.com/originals/d8/9e/d9/d89ed96e3cda94aff64b574662a621b3.jpg'),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Align(alignment: Alignment.topRight, child: favoriteIcon()),
            Positioned(bottom: 70, child: petName()),
            Positioned(bottom: 45, child: petInfo()),
            Positioned(bottom: 1, child: buildButton()),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return Center(
      child: PrimaryButton(
        onTap: () {},
        backgroundColor: AppColors.white.withOpacity(0.5),
        text: 'Saiba Mais',
        padding: const EdgeInsets.all(1),
        height: 10,
        width: 160,
        fontSize: 15,
      ),
    );
  }

  Widget cardScaffold({
    required Widget child,
  }) {
    return Center(
      child: GestureDetector(
        onTap: onTap as void Function()?,
        child: child,
      ),
    );
  }

  Widget petName() {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.maleIcon,
            color: AppColors.white, height: 24.0),
        const WidthSpacer(width: 2),
        Text(
          pet.name ?? "Sem nome",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.white,
            fontFamily: globalFontFamily,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget petInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          AppSvgs.locationIcon,
          color: AppColors.white,
          height: 10,
          width: 10,
        ),
        Text(
          ' ${pet.location?.address}' ?? 'Cidade Ficticia.',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.white,
            fontFamily: globalFontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
        const WidthSpacer(width: 12),
        Text(
          pet.age.toString() ?? "0",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.white,
            fontFamily: globalFontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget favoriteIcon() {
    return GestureDetector(
      onTap: onTapFavorite as void Function()?,
      child: CircleAvatar(
        backgroundColor: AppColors.white.withOpacity(0.5),
        child: SvgPicture.asset(
          isFavorited ? AppSvgs.heartIcon : AppSvgs.heartIcon,
          height: 24.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
