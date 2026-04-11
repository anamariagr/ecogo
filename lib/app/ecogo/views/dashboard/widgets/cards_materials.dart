import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsMaterials extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String textOnImage; // Texto que se mostrará sobre la imagen

  const CardsMaterials({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.textOnImage,
  }) : super(key: key);


  void _showDescription() {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        titlePadding: const EdgeInsets.only(left: 24, top: 16, right: 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                textOnImage,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back(); // Cierra el diálogo
              },
            ),
          ],
        ),
        content: Text(title), // Muestra la descripción aquí
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDescription,

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            // Imagen de fondo condicional: NetworkImage si es URL remota, AssetImage si es local
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageUrl.startsWith('http')
                      ? NetworkImage(imageUrl)
                      : AssetImage(imageUrl) as ImageProvider,
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
                textOnImage,
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
