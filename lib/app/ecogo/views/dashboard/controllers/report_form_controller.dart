// report_form_controller.dart
import 'dart:io';
import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:ecogo/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportFormController extends GetxController {
  final descriptionController = TextEditingController();
  final addressController = TextEditingController(); // Para la dirección manual
  var currentPosition = Rx<Position?>(null);
  var image = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  var address = Rx<String?>(null); // Almacena la dirección obtenida
  var isLoading = false.obs; // Estado de carga para el fetch de dirección
  final ReportService reportService = Get.find();
  final DashboardController controllerDashboard = Get.find();

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      getCurrentLocation();
    } else {
      Get.snackbar("Permiso denegado",
          "Es necesario el permiso de ubicación para reportar.");
    }
  }

  void resetForm() {
    descriptionController.clear();
    addressController.clear();
    currentPosition.value = null;
    image.value = null;
    address.value = null;
    isLoading.value = false;
  }

  Future<void> getCurrentLocation() async {
    try {
      if (currentPosition.value == null) {
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition.value = position;
      }

      final latitude = currentPosition.value?.latitude;
      final longitude = currentPosition.value?.longitude;

      await fetchAddressFromCoordinates(
          latitude!, longitude!); // Obtener la dirección
    } catch (e) {
      // Si falla, muestra un mensaje o deja que el usuario ingrese la dirección
      Get.snackbar("Error",
          "No se pudo obtener la ubicación, ingrese la dirección manualmente.");
    }
  }

  Future<void> fetchAddressFromCoordinates(
      double latitude, double longitude) async {
    isLoading.value = true; // Inicia el estado de carga
    final url = Uri.parse(
        'https://revgeocode.search.hereapi.com/v1/revgeocode?at=$latitude%2C$longitude&lang=en-US&apiKey=KDih3zUZ-C9Ez2WsPPeaw4vLskt9YWw9l2mHk8yA0KY');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var addressValue = data["items"][0]["address"];

        var street = addressValue["street"];
        var houseNumber = addressValue["houseNumber"];
        address.value = "${street} ${houseNumber}";
      } else {
        Get.snackbar("Error", "No se pudo obtener la dirección.");
      }
    } catch (e) {
      print("errror ${e}");
      Get.snackbar("Error", "Hubo un problema al obtener la dirección.");
    } finally {
      isLoading.value = false; // Finaliza el estado de carga
    }
  }

  Future<void> takePhoto() async {
    // Mostrar opciones para elegir entre cámara y galería
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar foto con cámara'),
              onTap: () async {
                final pickedImage =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  image.value = pickedImage;
                }
                Get.back(); // Cerrar el bottom sheet
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Seleccionar foto de galería'),
              onTap: () async {
                final pickedImage =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  image.value = pickedImage;
                }
                Get.back(); // Cerrar el bottom sheet
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendReport() async {
    if (image.value == null || descriptionController.text.isEmpty) {
      Get.snackbar(
          "Datos incompletos", "Por favor, completa todos los campos.");
      return;
    }

    final latitude = currentPosition.value?.latitude?.toString();
    final longitude = currentPosition.value?.longitude?.toString();
    final description = descriptionController.text;
    final addressValue = address.value ?? ''; // Si no hay valor, queda vacío
    final imagePath = image.value!;

    controllerDashboard.panelController.close();

    Get.snackbar(
      "Procesando",
      "Estamos enviando tu reporte. Por favor espera...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      isDismissible: false, // Evitar que se cierre manualmente
      duration: Duration(seconds: 2), // Mostrar durante 2 segundos
    );

    try {
      await reportService.sendMyReports(
        address: addressValue,
        latitude: latitude ?? '', // Si es null, queda como cadena vacía
        longitude: longitude ?? '', // Si es null, queda como cadena vacía
        comment: description,
        imageFile: imagePath,
      );

      Get.snackbar(
        "¡Éxito!",
        "Tu reporte ha sido enviado correctamente y esta pendiente por validar.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Mostrar mensaje de error si algo falla
      Get.snackbar(
        "Error",
        "No se pudo enviar el reporte. Inténtalo de nuevo.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      print("Error al enviar el reporte: $e");
    }
  }
}
