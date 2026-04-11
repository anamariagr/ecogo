// controllers/ranking_controller.dart

import 'package:ecogo/core/models/ranking.dart';
import 'package:ecogo/services/ranking_service.dart';
import 'package:get/get.dart';

class RankingController extends GetxController {
   final RankingService rankingService = Get.find();

  var ranking = <RankingUser>[].obs;
  var isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();

  }

  Future<void> fetchRankingData() async {
    try {
      isLoading.value = true;
      final fetchedRanking = await rankingService.fetchRanking();
      ranking.assignAll(fetchedRanking);
    } finally {
      isLoading.value = false;
    }
  }
}
