import 'package:ecogo/core/models/configuration.dart';
import 'package:ecogo/services/config_service.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  final ConfigService configService = Get.find();

  var config = Rxn<Configuration>(); // Observable de tipo Configuration

  @override
  void onInit() {
    super.onInit();

    loadConfig();
  }

  Future<void> loadConfig() async {
    final fetchedConfig = await configService.fetchConfigurations();
    if (fetchedConfig != null) {
      config.value = fetchedConfig;
    }
  }
}
