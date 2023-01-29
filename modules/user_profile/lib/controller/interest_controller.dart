import 'package:get/get.dart';
import 'package:user_profile/model/user.dart';

import 'package:user_profile/model/interest.dart';
import 'package:user_profile/repository/user_repository.dart';

class InterestController extends GetxController {
  final RxInt _interestedUserId = 0.obs;
  int get interestedUserId => _interestedUserId.value;
  set interestedUserId(int value) => _interestedUserId.value = value;
  final isLoading = false.obs;

  final _userList = <User>[].obs;
  get userList => _userList;

  Future<List<Interest>> getInterestByPet(int petId) async {
    _userList.clear();

    try {
      final UserRepository userRepository = Get.find();
      final list = await userRepository.getInterestsByPet(petId);
      final List<Interest> interestList = list
          .map(
            (e) => Interest.fromJson(e),
          )
          .toList();

      for (var interest in interestList) {
        _userList.add(interest.interestedUser!);
      }

      return interestList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Interest>> getInterestByUser(int userId) async {
    isLoading.value = true;
    try {
      final UserRepository userRepository = Get.find();
      final list = await userRepository.getInterestsByUser(userId);
      final List<Interest> interestList = list
          .map(
            (e) => Interest.fromJson(e),
          )
          .toList();
      isLoading.value = false;
      return interestList;
    } catch (e) {
      rethrow;
    }
  }

  Future<Interest> getInterestById(int interestId) async {
    isLoading.value = true;
    try {
      final UserRepository userRepository = Get.find();
      final Interest interest =
          await userRepository.getInterestById(interestId);
      isLoading.value = false;
      return interest;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveInterest(int userId, int petId) async {
    try {
      final UserRepository userRepository = Get.find();
      await userRepository.saveInterest(userId, petId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeInterest(Interest it) async {
    try {
      final UserRepository userRepository = Get.find();
      await userRepository.removeInterest(it);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateInterest(Interest it) async {
    try {
      final UserRepository userRepository = Get.find();
      await userRepository.updateInterest(it);
    } catch (e) {
      rethrow;
    }
  }
}
