import 'package:ecogo/app/ecogo/controllers/config_controller.dart';
import 'package:ecogo/app/ecogo/views/dashboard/widgets/cards_materials.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class MaterialListWidget extends StatelessWidget {
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final materials = configController.config.value?.materials;

      // Mostrar Shimmer si materials es null o está vacío
      if (materials == null || materials.isEmpty) {
        return _buildShimmerGrid();
      }

      // Mostrar contenido real cuando materials no es null ni vacío
      return SizedBox(
        height: 150,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: materials.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 6,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final material = materials[index];
            return CardsMaterials(
              imageUrl: material.image,
              textOnImage: material.title,
              title: material.description,
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
