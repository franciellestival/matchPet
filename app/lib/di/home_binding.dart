import 'package:api_services/api_services.dart';
import 'package:get/get.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/services/pet_services.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/repository/user_repository.dart';
import 'package:user_profile/services/user_services.dart';

class HomeBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // Injeta o userRepository como dependencia para utilizacao no app
    APIServices api = APIServices(Dio());
    UserServices userServices = UserServices(apiClient: api);
    UserRepository userRepository = UserRepository(userServices);
    Get.put<UserRepository>(userRepository, permanent: true);

    PetServices petServices = PetServices(petApi: api);
    PetRepository petRepository = PetRepository(petServices);
    Get.put<PetRepository>(petRepository, permanent: true);

    Get.put<Token>(Token());
  }
}
