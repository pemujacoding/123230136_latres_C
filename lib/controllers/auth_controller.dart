import 'package:get/get.dart';
import '../services/session_service.dart';
import '../views/login_view.dart';
import '../views/main_wrapper.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var currentUsername = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    bool loginStatus = await SessionService.isLoggedIn();
    if (loginStatus) {
      isLoggedIn.value = true;
      currentUsername.value = await SessionService.getUsername();
    }
  }

  void login(String username, String password) async {
    if (username.isNotEmpty && password == "123230136") {
      await SessionService.saveSession(username);
      currentUsername.value = username;
      isLoggedIn.value = true;
      Get.offAll(() => MainWrapper());
    } else {
      Get.snackbar("Error", "Username kosong atau Password (NIM) salah!");
    }
  }

  void logout() async {
    await SessionService.clearSession();
    isLoggedIn.value = false;
    currentUsername.value = '';
    Get.offAll(() => LoginView());
  }
}
