// services/ranking_service.dart

import 'package:ecogo/core/models/ranking.dart';
import 'package:get/get.dart';
 import 'api_client.dart';

class RankingService extends GetxService {
  final ApiClient apiClient;

  RankingService({required this.apiClient});

  Future<List<RankingUser>> fetchRanking() async {
    final response = await apiClient.get('/reports/ranking'); // Update path as needed

    if (response.isOk && response.body['success'] == true) {
      List<dynamic> rankingJson = response.body['ranking'];
      return rankingJson.map((json) => RankingUser.fromJson(json)).toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch ranking data');
      return [];
    }
  }
}
