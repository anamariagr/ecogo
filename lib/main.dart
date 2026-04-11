import 'package:ecogo/app/ecogo/controllers/auth_controller.dart';
import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:ecogo/services/api_client.dart';
import 'package:ecogo/services/auth_service.dart';
import 'package:ecogo/services/avatar_service.dart';
import 'package:ecogo/services/config_service.dart';
import 'package:ecogo/services/post_service.dart';
import 'package:ecogo/services/ranking_service.dart';
import 'package:ecogo/services/report_service.dart';
import 'package:ecogo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importar GetX
import 'package:ecogo/app/ecogo/views/dashboard/dashboard_page.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final apiClient = Get.put(ApiClient());
  final authService = AuthService(apiClient);

  Get.put(AuthController(authService));
  Get.put(ConfigService(apiClient: apiClient));  // Instancia de ConfigService
  Get.put(PostService(apiClient: apiClient));  // Instancia de ConfigService
  Get.put(ReportService(apiClient: apiClient));  // Instancia de ConfigService
  Get.put(RankingService(apiClient: apiClient));
  Get.put(AvatarService(apiClient: apiClient));
  Get.put(UserService(apiClient: apiClient));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    return GetMaterialApp( // Cambiar a GetMaterialApp
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Definir las rutas de la aplicación con GetX
      getPages: [
        GetPage(name: '/', page: () => Dashboard()), // Ruta principal
        // Puedes definir otras rutas aquí con GetPage
      ],
      initialRoute: '/', // Ruta inicial
    );
  }
}
