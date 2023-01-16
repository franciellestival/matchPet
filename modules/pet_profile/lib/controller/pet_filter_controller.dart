import 'package:get/get.dart';
import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/token.dart';

class FilterController extends GetxController {
  var userId = '1';

  @override
  void onInit() async {
    this.userId = await getUserId();
    super.onInit();
  }

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

  Future<String> getUserId() async {
    Token userToken = Get.find(tag: "userToken");

    final user = await UserController.getLoggedUserData(userToken);

    return user?.id?.toString() ?? '1';
  }

  String getQuery() {
    String query = '/pet?';

    if (dogSelected.value) query += 'species[]=dog&';
    if (catSelected.value) query += 'species[]=cat&';
    if (otherSelected.value) query += 'species[]=other&';
    if (maleSelected.value) query += 'gender[]=male&';
    if (femaleSelected.value) query += 'gender[]=female&';
    if (smallSelected.value) query += 'size[]=small&';
    if (mediumSelected.value) query += 'size[]=medium&';
    if (bigSelected.value) query += 'size[]=big&';

    query += 'minAge=${ageStartValue.round().toString()}&';
    query += 'maxAge=${ageEndValue.round().toString()}&';

    if (specialNeedsSelected.value) {
      query += 'special_need=0&';
    } else {
      query += 'special_need=1&';
    }

    query += 'userId=$userId';

    return query;
  }

  Map<String, String> getQueryMap() {
    Map<String, String> map = {};

    if (dogSelected.value) map.addEntries({'species': 'dog'}.entries);
    if (catSelected.value) map.addEntries({'species': 'cat'}.entries);
    if (otherSelected.value) map.addEntries({'species': 'other'}.entries);
    if (maleSelected.value) map.addEntries({'gender': 'male'}.entries);
    if (femaleSelected.value) map.addEntries({'gender': 'female'}.entries);
    if (smallSelected.value) map.addEntries({'size': 'small'}.entries);
    if (mediumSelected.value) map.addEntries({'size': 'medium'}.entries);
    if (bigSelected.value) map.addEntries({'size': 'big'}.entries);

    map.addEntries({'minAge': ageStartValue.round().toString()}.entries);
    map.addEntries({'maxAge': ageEndValue.round().toString()}.entries);

    if (specialNeedsSelected.value) {
      map.addEntries({'special_needs': '0'}.entries);
    } else {
      map.addEntries({'special_needs': '1'}.entries);
    }

    return map;
  }
}
