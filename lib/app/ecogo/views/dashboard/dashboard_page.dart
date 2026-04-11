import 'package:ecogo/app/ecogo/controllers/auth_controller.dart';
import 'package:ecogo/app/ecogo/controllers/avatar_controller.dart';
import 'package:ecogo/app/ecogo/controllers/config_controller.dart';
import 'package:ecogo/app/ecogo/controllers/post_controller.dart';
import 'package:ecogo/app/ecogo/controllers/ranking_controller.dart';
import 'package:ecogo/app/ecogo/controllers/report_controller.dart';
import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/report_form_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/report_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecogo/app/ecogo/views/home/home.dart';
import 'package:ecogo/app/ecogo/views/reports/reports_page.dart';
import 'package:ecogo/app/ecogo/views/ranking/ranking_page.dart';
import 'package:ecogo/app/ecogo/views/setings/setings_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});



  final DashboardController controller = Get.put(DashboardController());
  final ReportFormController controllerReport = Get.put(ReportFormController());
  final ConfigController configController = Get.put(ConfigController());
  final PostController postController = Get.put(PostController());
  final ReportController reportController = Get.put(ReportController());
  final RankingController rankingController = Get.put(RankingController());
  final AvatarController avatarController = Get.put(AvatarController());
  final UserController userController = Get.put(UserController());

  final AuthController authController = Get.find();
  final storage = GetStorage(); // Instancia de GetStorage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => LoadingOverlay(isLoading: controller.isLoading.value, child: SlidingUpPanel(
              minHeight: 0,
              maxHeight: controller.typeOfContent.value == 1
                  ? 220
                  : (controllerReport.image.value != null ? 450 : 350), // Cambia la altura máxima en función de la imagen
              backdropEnabled: true,
              controller: controller.panelController,
              body: Stack(
                children: [
                  PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: [
                      HomePage(
                        panelController: controller.panelController,
                      ),
                      const ReportsPage(),
                      const RankingPage(),
                      const SettingsPage(),
                    ],
                  ),
                  Obx(() {
                    return controller.selectedIndex.value != 2 && controller.selectedIndex.value != 3
                        ? Positioned(
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          width: 300,
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              controller.typeOfContent.value = 2;
                              controllerReport.resetForm();
                               controller.panelController.open();
                            },
                            label: const Text(
                              'Reportar Vertedero',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            backgroundColor: const Color.fromARGB(255, 49, 157, 207),
                          ),
                        ),
                      ),
                    )
                        : Container();
                  }),
                ],
              ),
              panel: Center(
                child: Obx(() {
                  // Muestra el contenido según el valor de typeOfContent
                  if (controller.typeOfContent.value == 1) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black54),
                            onPressed: () {
                              controller.panelController.close();
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: controller.handleSignIn,
                          icon: Image.asset(
                            'lib/core/assets/google.png',
                            height: 24,
                            width: 24,
                          ),
                          label: const Text(
                            "Iniciar sesión con Google",
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shadowColor: Colors.grey.withOpacity(0.3),
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Únete para reportar vertederos y ayudar a limpiar nuestras calles. Tu colaboración marca la diferencia.',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  } else if (controller.typeOfContent.value == 2) {
                    // Muestra el formulario de reporte de vertedero
                    return ReportForm();
                  } else {
                    return const SizedBox(); // Caso de contenido vacío
                  }
                }),
              ),
            )),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) async {

            if(index == 1){
              controller.isLoading.value = true;
              reportController.reportTab.value = 1;
              await reportController.fetchReports();
              controller.isLoading.value = false;
            }

            if(index == 2){
              controller.isLoading.value = true;
              reportController.reportTab.value = 1;
              await rankingController.fetchRankingData();
              controller.isLoading.value = false;
            }

            if(index == 3){
              controller.isLoading.value = true;

              await avatarController.fetchAvatars();
              controller.isLoading.value = false;
            }

            controller.pageController.jumpToPage(index);
            controller.onPageChanged(index);
            authController.isAuthenticated.value;
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color.fromARGB(255, 124, 192, 68),
          iconSize: 30,
          items:   [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.star_half_rounded),
              label: 'Reportes',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              label: 'Ranking',
            ),
            if (controller.isAuthorized.value)
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Ajustes',
              ),
          ],
        ),
      ),
    );
  }
}
