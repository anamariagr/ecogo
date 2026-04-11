import 'package:ecogo/app/ecogo/controllers/config_controller.dart';
import 'package:ecogo/app/ecogo/controllers/post_controller.dart';
import 'package:ecogo/app/ecogo/controllers/report_controller.dart';
import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/widgets/cards_materials.dart';
import 'package:ecogo/app/ecogo/views/dashboard/widgets/indicator.dart';
import 'package:ecogo/app/ecogo/views/home/widgets/materials_list_widget.dart';
import 'package:ecogo/app/ecogo/views/home/widgets/posts_list_widget.dart';
import 'package:ecogo/app/ecogo/views/home/widgets/user_getting_widget.dart';
import 'package:ecogo/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatelessWidget {
  final PanelController panelController;

  // Instancia del controlador de GetX
  final DashboardController controller = Get.find();
  final ConfigController configController = Get.find();
   final ReportController reportController = Get.find();
  final UserController userController = Get.find();
  final storage = GetStorage(); // Instancia de GetStorage

  HomePage({required this.panelController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(192, 32, 144, 209),
                                Color.fromARGB(192, 29, 138, 201),
                                Color.fromARGB(228, 37, 163, 185),
                                Color.fromARGB(174, 23, 155, 115),
                                Color.fromARGB(137, 30, 170, 49),
                                Color.fromARGB(132, 101, 211, 57),
                                Color.fromARGB(113, 111, 172, 32),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 30, left: 10, right: 10),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Obx(()=>UserGreetingWidget(
                                user: userController.user,
                                isAuthorized: controller.isAuthorized.value,
                                onRegisterTap: () {
                                  print("aquii estoy opriminedo ");
                                  panelController.open();
                                  controller.typeOfContent.value = 1;
                                },
                                onSignOut: () async {
                                  await controller.handleSignOut();
                                },
                              ))
                              ,
                              const SizedBox(height: 20),
                              const Text(
                                'Hemos logrado',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(() => configController.config.value == null
                                      ? _buildShimmerPlaceholderIndicator()
                                      : Indicator(
                                    indicator: 'Reportes',
                                    icon: Icons.energy_savings_leaf_rounded,
                                    col: Colors.blue,
                                    value: '${configController.config.value?.reportLimit ?? 0} kg',
                                    label: 'Vertederos',
                                  )),
                                  Obx(() => configController.config.value == null
                                      ? _buildShimmerPlaceholderIndicator()
                                      : Indicator(
                                    indicator: 'Recoleccion',
                                    icon: Icons.cloud_done_sharp,
                                    col: Color.fromARGB(255, 175, 31, 211),
                                    value:
                                    '${configController.config.value?.collectionKilos ?? 0} kg',
                                    label: 'Residuos',
                                  )),
                                  Obx(() => configController.config.value == null
                                      ? _buildShimmerPlaceholderIndicator()
                                      : Indicator(
                                    indicator: 'Reciclaje',
                                    col: Colors.green,
                                    icon: Icons.recycling,
                                    value: '${configController.config.value?.recyclingKilos ?? 0} kg',
                                    label: 'Residuos',
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 10.0, top: 16, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lo que encontramos',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        MaterialListWidget(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 16, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Noticias',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Ver todo',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 59, 59, 59),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PostGridWidget(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Vertederos Reportados',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  controller.isLoading.value = true;

                                  await reportController.fetchMyReports();
                                  controller.selectedIndex.value = 1;
                                  controller.pageController.jumpToPage(1);
                                  controller.onPageChanged(1);
                                  controller.isLoading.value = false;
                                },
                                child: const Text(
                                  'Ver todo',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 59, 59, 59),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            controller.isLoading.value = true;
                            await reportController.fetchReports();
                            controller.selectedIndex.value = 1;
                            controller.pageController.jumpToPage(1);
                            controller.onPageChanged(1);
                            controller.isLoading.value = false;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 80),
                            height: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('lib/core/assets/map.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildShimmerPlaceholderIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
