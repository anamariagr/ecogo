import 'package:flutter/material.dart';

// Este widget acepta datos dinámicos como nombre, correo y universidad.
class ProfileWidgetPage extends StatelessWidget {
  final String name;
  final String email;
  final String university;

  const ProfileWidgetPage({
    Key? key,
    required this.name,
    required this.email,
    required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        // Nombre del usuario
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        // Correo del usuario
        Text(
          email,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        // Universidad del usuario
        Text(
          university,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
