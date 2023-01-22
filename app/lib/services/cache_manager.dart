import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_profile/model/token.dart';

mixin CacheManager {
  Future<bool> saveToken(Token userToken) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ID.toString(), userToken.id.toString());
    await box.write(
        CacheManagerKey.TOKEN.toString(), userToken.token.toString());
    Get.put<Token>(userToken, tag: "userToken", permanent: true);
    return true;
  }

  Token? getToken() {
    final box = GetStorage();
    int? userId = int.tryParse(box.read(CacheManagerKey.ID.toString()) ?? "");

    return (userId == null)
        ? null
        : Token(id: userId, token: box.read(CacheManagerKey.TOKEN.toString()));
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.ID.toString());
    await box.remove(CacheManagerKey.TOKEN.toString());
    Get.delete<Token>(tag: 'userToken', force: true);
  }
}

enum CacheManagerKey { TOKEN, ID }
