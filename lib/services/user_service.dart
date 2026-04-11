// services/user_service.dart
import 'package:get/get.dart';
import 'package:ecogo/core/models/user.dart';
import 'api_client.dart';

class UserService extends GetxService {
  final ApiClient apiClient;

  UserService({required this.apiClient});

  Future<User?> fetchUserData() async {
    final response = await apiClient.get('/user');

    if (response.isOk) {
      return User.fromJson(response.body);
    } else {
       return null;
    }
  }

  Future<bool> updateUserProfile(
      {required String name, required String profilePhoto}) async {
    final response = await apiClient.put('/user/profile', {
      "name": name,
      "profile_photo": profilePhoto,
    });

    if (response.isOk) {
      Get.snackbar('Éxito', 'Tu perfil ha sido actualizado correctamente.');
      return true;
    } else {
       return false;
    }
  }
}
