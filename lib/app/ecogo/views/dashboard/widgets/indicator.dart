import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final IconData icon;
  final Color col;
  final String value;
  final String label;

  // Constructor del widget Indicator
   const Indicator({
    super.key,
    required this.col,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return _buildIndicator(icon, value, label);
  }

  Widget _buildIndicator(IconData icon, String? value, String? label) {
    return Column(
      children: [
        Container(
          height: 105,
          width: 100,
          margin: const EdgeInsets.only(left: 0),
          padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10), // Ajustar padding
          decoration: BoxDecoration(
            color: const Color.fromARGB(239, 247, 255, 249),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Icon(icon, size: 30, color: col), // Propiedad color corregida
              const SizedBox(height: 4),
              Text(value ?? '0',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(label ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
