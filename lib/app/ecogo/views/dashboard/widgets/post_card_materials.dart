import 'package:ecogo/app/ecogo/views/dashboard/widgets/post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class PostCardsMaterials extends StatelessWidget {
  final String image;
  final String title;
  final String description; // Contenido que puede incluir HTML

  const PostCardsMaterials({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  void _showPostDetail(BuildContext context) {
    Get.to(() => PostDetailScreen(
      title: title,
      image: image,
      description: description,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPostDetail(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            // Imagen de fondo condicional: NetworkImage si es URL remota, AssetImage si es local
            if (image.isNotEmpty)
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: image.startsWith('http')
                        ? NetworkImage(image)
                        : AssetImage(image) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color.fromARGB(171, 0, 0, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

