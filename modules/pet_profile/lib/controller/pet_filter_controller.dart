import 'package:get/get.dart';

class FilterController extends GetxController {
  var ageStartValue = 0.0.obs;
  var distanceStartValue = 10.0.obs;
  var ageEndValue = 10.0.obs;
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
}
