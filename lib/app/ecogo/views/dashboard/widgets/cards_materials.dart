import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
         
          Container(
            height: 150, 
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imageUrl),
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
    );
  }
}
