import 'package:get/get.dart';
import 'package:user_profile/model/user_location.dart';
import 'package:user_profile/repository/user_repository.dart';

class FilterController extends GetxController {
  final RxBool isLoading = false.obs;

  final RxInt _ageStart = 0.obs;
  final RxInt _ageEnd = 15.obs;

  int get ageStart => _ageStart.value;
  set ageStart(int value) => _ageStart.value = value;

  int get ageEnd => _ageEnd.value;
  set ageEnd(int value) => _ageEnd.value = value;

  final RxInt _distanceSlider = 10.obs;

  int get distanceSlider => _distanceSlider.value;
  set distanceSlider(int value) => _distanceSlider.value = value;

  RxBool dogSelected = false.obs;
  RxBool catSelected = false.obs;
  RxBool otherSelected = false.obs;

  RxBool maleSelected = false.obs;
  RxBool femaleSelected = false.obs;

  RxBool smallSelected = false.obs;
  RxBool mediumSelected = false.obs;
  RxBool bigSelected = false.obs;

  RxBool specialNeedYesSelected = false.obs;
  RxBool specialNeedNoSelected = false.obs;

  Future<Map<String, dynamic>> getQueryMap() async {
    final UserRepository userRepository = Get.find();
    final bool isDogSelected = dogSelected.value;
    final bool isCatSelected = catSelected.value;
    final bool isOtherSelected = otherSelected.value;
    final bool isMaleSelected = maleSelected.value;
    final bool isFemaleSelected = femaleSelected.value;
    final bool isSmallSelected = smallSelected.value;
    final bool isMediumSelected = mediumSelected.value;
    final bool isBigSelected = bigSelected.value;
    final bool isSpecialNeedYes = specialNeedYesSelected.value;
    final bool isSpecialNeedNo = specialNeedNoSelected.value;
    final int minAge = ageStart.round();
    final int maxAge = ageEnd.round();
    final int distance = distanceSlider.round();

    Set<String> species = {};
    if (isDogSelected) species.add('dog');
    if (isCatSelected) species.add('cat');
    if (isOtherSelected) species.add('others');

    Set<String> gender = {};
    if (isMaleSelected) gender.add('male');
    if (isFemaleSelected) gender.add('female');

    Set<String> size = {};
    if (isSmallSelected) size.add('small');
    if (isMediumSelected) size.add('medium');
    if (isBigSelected) size.add('big');

    Map<String, dynamic> map = {};
    if (species.isNotEmpty) {
      map['species'] = species.join(',');
    }
    if (gender.isNotEmpty) {
      map['gender'] = gender.join(',');
    }
    if (size.isNotEmpty) {
      map['size'] = size.join(',');
    }
    map['minAge'] = minAge;
    map['maxAge'] = maxAge;

    // So vai preencher o special_need se marcou algum dos dois (yes/no)
    if (isSpecialNeedNo ^ isSpecialNeedYes) {
      map['special_need'] = isSpecialNeedYes ? 'yes' : 'no';
    }

    final UserLocation? location = await userRepository.getCurrentLocation();

    if (location != null) {
      map['distance'] = distance;
      map['lat'] = location.lat;
      map['lng'] = location.lng;
    }
    return map;
  }
}
