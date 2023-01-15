import 'package:get/get.dart';

class ImageController extends GetxController {
  var isImagePathSet = false.obs;
  var isImageURLSet = false.obs;
  var imagePath = "".obs;
  var imageURL = "".obs;

  void setImagePath(String path) {
    imagePath.value = path;
    isImagePathSet.value = true;
  }

  void setImageURL(String url) {
    imageURL.value = url;
    isImageURLSet.value = true;
  }

  void unsetImagePath() {
    imagePath.value = '';
    isImagePathSet.value = false;
  }

  void unsetImageURL() {
    imageURL.value = '';
    isImageURLSet.value = false;
  }
}
