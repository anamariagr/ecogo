import 'package:ecogo/app/ecogo/controllers/post_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/widgets/cards_materials.dart';
import 'package:ecogo/app/ecogo/views/dashboard/widgets/post_card_materials.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class PostGridWidget extends StatelessWidget {
  final PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final posts = postController.posts.value;

      // Mostrar Shimmer si posts es null o está vacío
      if (posts == null || posts.isEmpty) {
        return _buildShimmerGrid();
      }

      // Mostrar contenido real cuando posts no es null ni vacío
      return SizedBox(
        height: 150,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 6,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCardsMaterials(
              image: post.image,
              title: post.title,
              description: post.content,
            );
          },
        ),
      );
    });
  }

  // Construcción de Shimmer para la cuadrícula
  Widget _buildShimmerGrid() {
    return SizedBox(
      height: 150,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Número de marcadores de posición Shimmer
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 6,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120, // Ancho aproximado del contenido real
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
