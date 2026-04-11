// services/post_service.dart

import 'package:ecogo/core/models/post.dart';
import 'package:get/get.dart';
import 'api_client.dart';

class PostService extends GetxService {
  final ApiClient apiClient;

  PostService({required this.apiClient});

  Future<List<Post>> fetchPosts({int page = 1, int limit = 10}) async {
    final response = await apiClient.get(
      '/posts',
      query: {'page': page.toString(), 'limit': limit.toString()},
    );

    print("todos los posts ${response.body}");
    if (response.isOk) {
      List<dynamic> postsJson = response.body['posts'];
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch posts');
      return [];
    }
  }
}
