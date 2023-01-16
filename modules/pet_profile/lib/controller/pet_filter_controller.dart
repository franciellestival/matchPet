import 'package:get/get.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/widgets/pet_card.dart';
import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/token.dart';

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

    if (dogSelected.value) map.addEntries({'species': 'dog'}.entries);
    if (catSelected.value) map.addEntries({'species': 'cat'}.entries);
    if (otherSelected.value) map.addEntries({'species': 'others'}.entries);
    if (maleSelected.value) map.addEntries({'gender': 'male'}.entries);
    if (femaleSelected.value) map.addEntries({'gender': 'female'}.entries);
    if (smallSelected.value) map.addEntries({'size': 'small'}.entries);
    if (mediumSelected.value) map.addEntries({'size': 'medium'}.entries);
    if (bigSelected.value) map.addEntries({'size': 'big'}.entries);

    map.addEntries({'minAge': ageStartValue.round().toString()}.entries);
    map.addEntries({'maxAge': ageEndValue.round().toString()}.entries);

    if (specialNeedsSelected.value) {
      map.addEntries({'special_need': '0'}.entries);
    } else {
      map.addEntries({'special_need': '1'}.entries);
    }

    return map;
  }
}
