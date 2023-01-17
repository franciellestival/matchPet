import 'package:get/get.dart';

class FilterController extends GetxController {
  var ageStartValue = 0.0.obs;
  var ageEndValue = 10.0.obs;

  var distanceStartValue = 10.0.obs;
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

  Map<String, dynamic> getQueryMap() {
    Map<String, dynamic> map = {};

    List<String> speciesList = [];
    List<String> genderList = [];
    List<String> sizeList = [];

    if (dogSelected.value) speciesList.add('dog');
    if (catSelected.value) speciesList.add('cat');
    if (otherSelected.value) speciesList.add('others');

    if (maleSelected.value) genderList.add('male');
    if (femaleSelected.value) genderList.add('female');

    if (smallSelected.value) sizeList.add('small');
    if (mediumSelected.value) sizeList.add('medium');
    if (bigSelected.value) sizeList.add('big');

    if (speciesList.isNotEmpty) {
      map.addEntries({'species': speciesList.join(',')}.entries);
    }
    if (genderList.isNotEmpty) {
      map.addEntries({'gender': genderList.join(',')}.entries);
    }
    if (sizeList.isNotEmpty) {
      map.addEntries({'size': sizeList.join(',')}.entries);
    }

    map.addEntries({'minAge': ageStartValue.round().toString()}.entries);
    map.addEntries({'maxAge': ageEndValue.round().toString()}.entries);
    map.addEntries(
        {'special_need': specialNeedsSelected.value ? '0' : '1'}.entries);

    return map;
  }
}
