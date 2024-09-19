import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final PageController pageController;

  // Añadir PageController como parámetro del constructor
  AppDrawer({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
               gradient: LinearGradient(
              colors: [
                Color.fromARGB(179, 38, 134, 54),
                Color.fromARGB(176, 73, 184, 119),
                Color.fromARGB(176, 75, 192, 123),
                Color.fromARGB(175, 64, 161, 105),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
            ),
            child: Text(
              'Menú ',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              pageController.jumpToPage(0); // Navegar a la página 0
              Navigator.pop(context); // Cerrar el Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online_sharp),
            title: const Text('Noticias'),
            onTap: () {
              pageController.jumpToPage(1); // Navegar a la página 1
              Navigator.pop(context); // Cerrar el Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard_outlined),
            title: const Text('Ranking'),
            onTap: () {
              pageController.jumpToPage(2); // Navegar a la página 2
              Navigator.pop(context); // Cerrar el Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              pageController.jumpToPage(3); // Navegar a la página 3
              Navigator.pop(context); // Cerrar el Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_half_rounded),
            title: const Text('Reportes'),
            onTap: () {
              pageController.jumpToPage(4); // Navegar a la página 4
              Navigator.pop(context); // Cerrar el Drawer
            },
          ),
        ],
      ),
    );
  }
}
