import 'package:api_services/api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/services/pet_services.dart';
import 'package:user_profile/model/token.dart';

void main() {
  final Token token = Token(
      id: 3,
      token:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozfQ.SrBAzWrzB1Flj3Yw-uTTOHDx70RiYmICnyi_GlNTT48");
  Get.put<Token>(token, tag: "userToken");
  final APIServices api = APIServices(Dio());
  final PetServices petServices = PetServices(petApi: api);
  final PetRepository petRepository = PetRepository(petServices);

  test('Test request Genders', () async {
    var lista = await petRepository.getGenders();

    expect(lista?.length, 2);
  });

  test('Test request Status', () async {
    var lista = await petRepository.getStatus();

    expect(lista?.length, 2);
  });

  test('Test filter request', () async {
    final Map<String, String> filters = {"specie": "dog"};
    var lista = await petRepository.getFilteredPets(filters);
    expect(lista?.length, 0);
  });
}
