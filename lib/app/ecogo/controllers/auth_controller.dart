import 'package:ecogo/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService authService;

  AuthController(this.authService);

  var isAuthenticated = false.obs;

  Future<void> login(String email, String googleId) async {
    isAuthenticated.value = await authService.login(email, googleId);
  }


  Future<void> loginOrRegister(String email, String googleId, String? name, String? profilePhoto) async {
    await this.login(email, googleId);
    if(!isAuthenticated.value){
       await this.register(email, googleId, name, profilePhoto);
    }
  }


  Future<void> register(String email, String googleId, String? name, String? profilePhoto) async {
    isAuthenticated.value = await authService.register(email, googleId, name!, profilePhoto);
  }

  void logout() {
    authService.logout();
    isAuthenticated.value = false;
  }
}
