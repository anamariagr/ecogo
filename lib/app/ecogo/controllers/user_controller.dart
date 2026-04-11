import 'package:ecogo/main.dart';
import 'package:ecogo/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecogo/core/models/user.dart';

class UserController extends GetxController {
  final UserService userService = Get.find();

  var user = Rxn<User>();
  var isLoading = false.obs;
  final usernameController = TextEditingController().obs;

  // Renamed to avoid conflicts
  var selectedAvatarRx = ''.obs;

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> fetchUser() async {
    isLoading.value = true;

    user.value = await userService.fetchUserData();
    usernameController.value.text = user.value?.name ?? '';

    User? userTemp = user.value;
    if (userTemp != null) {
      String foto = userTemp.profilePhoto;
      selectedAvatarRx.value = foto;
    }

    isLoading.value = false;
  }

  Future<void> updateUserProfile() async {
    isLoading.value = true;

    final name = usernameController.value.text; // Accede directamente al texto
    final profilePhoto = selectedAvatarRx.value; // Asegúrate de que selectedAvatar es RxString

    bool success = await userService.updateUserProfile(
      name: name,
      profilePhoto: profilePhoto,
    );

    if (success) {
      // Actualizar el objeto user con los nuevos valores
      user.value = User(
        id: user.value?.id ?? 0,
        name: name,
        profilePhoto: profilePhoto,
        email: user.value?.email ?? "",
        googleId: user.value?.googleId ?? "",
        createdAt: user.value?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        // Agrega otros campos necesarios aquí
      );
      user.refresh(); // Notificar para actualizar la UI


    } else {
      // Manejar el caso de fallo si es necesario
      Get.snackbar('Error', 'No se pudo actualizar el perfil.');
    }

    isLoading.value = false;
  }


}
