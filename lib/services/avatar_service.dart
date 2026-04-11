// services/avatar_service.dart

import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:ecogo/core/models/user.dart';
import 'package:get/get.dart';
import 'package:ecogo/core/models/avatar.dart';
import 'api_client.dart';

class AvatarService extends GetxService {
  final ApiClient apiClient;

  AvatarService({required this.apiClient});

  Future<List<Avatar>> fetchAvatars() async {
    UserController userController = Get.find();

    final response = await apiClient.get('/avatars');

    User? user = userController.user.value;
    if (response.isOk) {
      List<dynamic> avatarsJson = response.body['avatars'];

      // Verificar si la foto de perfil del usuario ya está en la lista
      int existingIndex = avatarsJson.indexWhere((avatar) =>
      avatar['image_url'] == user?.profilePhoto);

      if (existingIndex != -1) {
        // Si la foto de perfil existe en la lista, moverla al inicio
        var userAvatar = avatarsJson.removeAt(existingIndex);
        avatarsJson.insert(0, userAvatar);
      } else if (user?.profilePhoto != null) {
        // Si la foto de perfil no está en la lista y no es nula, agregarla al inicio
        avatarsJson.insert(0, {"id": 0, "image_url": user?.profilePhoto});
      }

      print("Avatars list: $avatarsJson");
      return avatarsJson.map((json) => Avatar.fromJson(json)).toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch avatars');
      return [];
    }
  }


}
