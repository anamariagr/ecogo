import 'dart:io';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/report_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportForm extends StatelessWidget {
  ReportForm({super.key});

  final ReportFormController controller = Get.find();
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black54),
              onPressed: () {
                dashboardController.panelController.close();
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Reportar Vertedero',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator(); // Muestra el indicador de carga
            } else {
              // Agregar dirección al campo de descripción si está disponible
              if (controller.address.value != null) {
                controller.descriptionController.text =
                'Encontré un vertedero en ${controller.address.value}. ';
              }
              return Stack(
                children: [
                  // TextField
                  TextField(
                    controller: controller.descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción del vertedero',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0, // Padding interno vertical
                        horizontal: 20.0, // Padding interno horizontal
                      ),
                    ),
                    maxLines: null,
                    minLines: 2,
                  ),
                  // Ícono de geolocalización
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () async {
                        await controller.requestLocationPermission();

                        Get.snackbar(
                          "Geolocalización",
                          "Geolocalizando...",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blueAccent,
                          colorText: Colors.white,
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: controller.takePhoto,
            icon: const Icon(Icons.camera_alt),
            label: const Text("Tomar Foto"),
          ),
          Obx(() {
            final image = controller.image.value;
            return image != null
                ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.file(
                File(image.path),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            )
                : const SizedBox();
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.sendReport,
            child: const Text('Enviar Reporte'),
          ),
        ],
      ),
    );
  }
}
