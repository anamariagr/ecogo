// controllers/post_controller.dart

import 'package:ecogo/core/models/post.dart';
import 'package:ecogo/services/post_service.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final PostService postService = Get.find();

  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var currentPage = 1;
  final int limit = 5;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts({int page = 1}) async {
    isLoading.value = true;
    currentPage = page;

    final fetchedPosts = await postService.fetchPosts(page: page, limit: limit);
    if (fetchedPosts.isNotEmpty) {
      posts.assignAll(fetchedPosts);
    }

    isLoading.value = false;
  }
}
