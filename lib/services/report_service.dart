// services/report_service.dart

import 'package:ecogo/app/ecogo/views/dashboard/controllers/dashboard_controller.dart';
import 'package:ecogo/core/models/report.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'api_client.dart';

class ReportService extends GetxService {
  final ApiClient apiClient;
  final DashboardController controller = Get.find();

  ReportService({required this.apiClient});

  Future<List<Report>> fetchReports({int page = 1, int limit = 10}) async {
    final response = await apiClient.get(
      '/reports',
      query: {'page': page.toString(), 'limit': limit.toString()},
    );

    print("Todos los reportes ${response.isOk} ${response.body}");
    if (response.isOk) {
      List<dynamic> reportsJson = response.body['reports'];
      return reportsJson.map((json) => Report.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Report>> fetchMyReports({int page = 1, int limit = 10}) async {
    final response = await apiClient.get(
      '/user-reports',
      query: {'page': page.toString(), 'limit': limit.toString()},
    );

    print("Todos los reportes mios ${response.isOk} ${response.body}");
    if (response.isOk) {
      List<dynamic> reportsJson = response.body['reports'];
      return reportsJson.map((json) => Report.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> sendMyReports({
    String? latitude,
    String? longitude,
    required String comment,
    required String? address,
    required XFile imageFile, // Recibir el archivo de imagen
  }) async {
    final formData = FormData({
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'comment': comment,
      'image': MultipartFile(
        imageFile.path, // Provide the file path directly
        filename: imageFile.name,
      ),
    });
    var response = await apiClient.post('/reports', formData);
    if (response.isOk) {
      final reportId = response.body["report"]["id"];

      final isLoggedIn = GetStorage().read('isLoggedIn') ?? false;

      if (!controller.isAuthorized.value) {

        final storage = GetStorage();
        final List<int> reportIds =
            (storage.read('pendingReportIds') ?? []).cast<int>();
        reportIds.add(reportId);
        storage.write('pendingReportIds', reportIds);
      }

      fetchMyReports();

    }
  }


  Future<void> linkPendingReportsToUser() async {
    final storage = GetStorage();
    final List<int> pendingReportIds =
    (storage.read('pendingReportIds') ?? []).cast<int>();

    if (pendingReportIds.isEmpty) {
      print("No hay reportes pendientes para vincular.");
      return;
    }

    for (int reportId in pendingReportIds) {
      try {
        // Enviar solicitud PUT al endpoint
        final response = await apiClient.put('/reports/$reportId/link', {});

        if (response.isOk) {
          print("Reporte $reportId vinculado exitosamente.");
        } else {
          print("Error al vincular el reporte $reportId: ${response.body}");
        }
      } catch (e) {
        print("Excepción al vincular el reporte $reportId: $e");
      }
    }

    // Limpiar los IDs pendientes después de vincularlos
    storage.remove('pendingReportIds');
    print("Todos los reportes pendientes han sido procesados.");
  }


}
