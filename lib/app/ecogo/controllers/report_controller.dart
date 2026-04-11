// controllers/report_controller.dart

import 'package:ecogo/core/models/report.dart';
import 'package:ecogo/services/report_service.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final ReportService reportService = Get.find();

  var reports = <Report>[].obs;
  var myReports = <Report>[].obs;
  var isLoading = false.obs;
  var currentPage = 1.obs;
  var limit = 10.obs;

  var reportTab = 0.obs;

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> fetchMyReports() async {
    isLoading.value = true;

    try {
      final fetchedReports = await reportService.fetchMyReports(
        page: currentPage.value,
        limit: limit.value,
      );
      myReports.value = fetchedReports;
    } catch (e) {
     } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReports() async {
    isLoading.value = true;

    try {
      final fetchedReports = await reportService.fetchReports(
        page: currentPage.value,
        limit: limit.value,
      );
      reports.value = fetchedReports;
  } catch (e) {
     } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    currentPage.value++;
    fetchReports();
  }
}
