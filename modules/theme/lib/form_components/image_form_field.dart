import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../export_theme.dart';

class ImageInput extends StatelessWidget {
  final String placeHolderPath;
  final bool isEnabled;

  XFile? pickedFile;
  ImagePicker imagePicker = ImagePicker();

  ImageController imageController = Get.find();

  ImageInput(
      {required this.placeHolderPath, required this.isEnabled, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
                height: 150,
                width: 150,
                child: DecoratedBox(
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        strokeAlign: BorderSide.strokeAlignInside,
                        width: 2,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  child: Obx(() => _imageLoader()),
                )),
            Positioned(
              left: 110,
              bottom: 1,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 1,
                      color: AppColors.white,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.buttonColor,
                    child: IconButton(
                      icon: const Icon(
                        color: AppColors.white,
                        Icons.add_a_photo_outlined,
                        size: 25.0,
                      ),
                      onPressed: isEnabled
                          ? () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => bottonSheet(context));
                            }
                          : null,
                      // onPressed: () {
                      //   showModalBottomSheet(
                      //       context: context,
                      //       builder: (context) => bottonSheet(context));
                      // },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottonSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      width: double.infinity,
      height: size.height * 0.2,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(children: [
        const Text(
          "Escolha a foto do Pet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.image,
                  color: AppColors.buttonColor,
                ),
                SizedBox(height: 5),
                Text(
                  "Galeria",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            onTap: () async {
              if (await requestGalleryPermission()) {
                getPhoto(ImageSource.gallery);
              }
            },
          ),
          const SizedBox(width: 80),
          InkWell(
            child: Column(
              children: const [
                Icon(
                  Icons.camera,
                  color: AppColors.buttonColor,
                ),
                SizedBox(height: 5),
                Text(
                  "Tirar foto",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            onTap: () async {
              if (await requestCameraPermission()) {
                getPhoto(ImageSource.camera);
              }
            },
          )
        ])
      ]),
    );
  }

  Future<void> getPhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    if (pickedImage != null) {
      pickedFile = XFile(pickedImage.path);
      imageController.setImagePath(pickedFile!.path);
      imageController.unsetImageURL();
    }

    Get.back();
  }

  Future<bool> requestGalleryPermission() async {
    var permission = Platform.isIOS ? Permission.photos : Permission.storage;

    var status = await permission.status;

    if (!status.isGranted) {
      if (await permission.request().isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      if (await Permission.camera.request().isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  CircleAvatar _imageLoader() {
    if (imageController.isImagePathSet.value) {
      return CircleAvatar(
          radius: 100,
          backgroundImage: FileImage(File(imageController.imagePath.value)));
    }

    if (imageController.isImageURLSet.value) {
      return CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage(imageController.imageURL.value));
    }
    return CircleAvatar(
        radius: 100,
        backgroundColor: AppColors.editTextColor,
        child: SvgPicture.asset(
          color: AppColors.hintTextColor,
          placeHolderPath,
          width: 110,
          height: 110,
        ));
  }
}
