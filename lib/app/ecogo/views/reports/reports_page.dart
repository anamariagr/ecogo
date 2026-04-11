import 'package:ecogo/app/ecogo/controllers/auth_controller.dart';
import 'package:ecogo/app/ecogo/controllers/report_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecogo/core/components/app_drawer.dart';
import 'package:get_storage/get_storage.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ReportController reportsController = Get.put(ReportController());
    final DashboardController dashboardController = Get.find();
    final AuthController authController = Get.find();
    final storage = GetStorage(); // Instancia de GetStorage

    return Scaffold(
      drawer: AppDrawer(pageController: pageController),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
               gradient: LinearGradient(
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
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        color: const Color.fromARGB(255, 238, 238, 238),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                  Row(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.monetization_on, color: Colors.amber),
                          SizedBox(width: 5),
                          Text(
                            '300',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 238, 238, 238),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        color: const Color.fromARGB(255, 238, 238, 238),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
             margin: const EdgeInsets.only(top: 20, left: 16,right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Obx(()=>Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    dashboardController.isLoading.value = true;

                    await reportsController.fetchReports();
                    dashboardController.isLoading.value = false;

                    reportsController.reportTab.value = 1;
                  },
                  child: Container(
                    color: Colors.transparent,

                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Text(
                      'Últimos reportes',
                      style: TextStyle(
                        fontSize: 13,
                        color: reportsController.reportTab.value  == 1 ? Colors.green :  Colors.black54,
                      ),
                    ),
                  )
                ),

                dashboardController.isAuthorized.value ? const SizedBox(width: 20) : Container(),

                dashboardController.isAuthorized.value ?  GestureDetector(
                    onTap: () async {
                      dashboardController.isLoading.value = true;

                      await reportsController.fetchMyReports();
                      dashboardController.isLoading.value = false;
                      reportsController.reportTab.value = 2;
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 10,bottom: 10),

                      child: Text(
                        'Mis reportes',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: reportsController.reportTab.value  == 2 ? Colors.green :  Colors.black54,
                        ),
                      ),
                    ),
                  ): Container(),

              ],
            )),
          ),
          Obx(()=>reportsController.reportTab.value == 1 ? Expanded(
            child: reportsController.reports.isNotEmpty ? GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: reportsController.reports.length,
              itemBuilder: (context, index) {
                final report = reportsController.reports[index];

                print("aquii el report ${report.imageUrl}");
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          report.imageUrl ?? 'lib/core/assets/new.png',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'lib/core/assets/new.png',
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              report.comment.length > 15
                                  ? '${report.comment.substring(0, 15)}...'
                                  : report.comment,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ): const Center(
              child: Text("Aún no has reportado ningún vertedero"),
            ),

          ): Container()),
          Obx(()=>reportsController.reportTab.value == 2 ? Expanded(
            child:  reportsController.myReports.isNotEmpty ? GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: reportsController.myReports.length,
              itemBuilder: (context, index) {
                final report = reportsController.myReports[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          report.imageUrl ?? 'lib/core/assets/new.png',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'lib/core/assets/new.png',
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              report.comment.length > 15
                                  ? '${report.comment.substring(0, 15)}...'
                                  : report.comment,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ): const Center(
              child: Text("Aún no has reportado ningún vertedero"),
            ),

          ) : Container()),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
