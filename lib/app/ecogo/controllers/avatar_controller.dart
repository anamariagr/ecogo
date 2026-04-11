// controllers/avatar_controller.dart

import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:ecogo/core/models/avatar.dart';
import 'package:ecogo/services/avatar_service.dart';

class AvatarController extends GetxController {
  final AvatarService avatarService = Get.find();

  var avatars = <Avatar>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
   }

  Future<void>  fetchAvatars() async {
    isLoading.value = true;
    avatars.value = await avatarService.fetchAvatars();
    isLoading.value = false;
  }
}
