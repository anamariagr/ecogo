import 'package:ecogo/core/models/configuration.dart';
import 'package:get/get.dart';
import 'api_client.dart';

class ConfigService extends GetxService {
  final ApiClient apiClient;

  ConfigService({required this.apiClient});


  Future<Configuration?> fetchConfigurations() async {
    final response = await apiClient.get('/configurations');

    if (response.isOk) {
      return Configuration.fromJson(response.body);
    } else {
      Get.snackbar('Error', 'Failed to fetch configurations');
      return null;
    }
  }
}
