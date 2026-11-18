import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxString email = ''.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    if (savedEmail != null && savedEmail.isNotEmpty) {
      email.value = savedEmail;
      isLoggedIn.value = true;
    }
  }

  Future<String?> login(String inputEmail, String password) async {
    if (inputEmail.trim().isEmpty || password.trim().isEmpty) {
      return 'Email dan Password tidak boleh kosong';
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', inputEmail.trim());
    email.value = inputEmail.trim();
    isLoggedIn.value = true;
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    email.value = '';
    isLoggedIn.value = false;
  }
}