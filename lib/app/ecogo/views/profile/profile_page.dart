import 'package:flutter/material.dart';
import 'package:ecogo/app/ecogo/views/profile/widgets/profile_widget_page.dart';
import 'package:ecogo/app/ecogo/views/profile/widgets/points_widget_page.dart';
import 'package:ecogo/core/components/app_drawer.dart'; 
import 'package:ecogo/app/ecogo/views/profile/widgets/menu_option_widget.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(); 

    return Scaffold(
      drawer: AppDrawer(pageController: pageController), 
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu),
                        color: const Color.fromARGB(255, 238, 238, 238),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.monetization_on, color: Colors.amber),
                            SizedBox(width: 5),
                            Text(
                              '300',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 238, 238, 238),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {
                            // Acción para la notificación
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('lib/core/assets/face-1.png'),
                          ),
                          const ProfileWidgetPage(
                            name: 'Thomas Deo',
                            email: 'Thomas.bates@student.gsu.edu',
                            university: 'Georgia State University',
                          ),
                          const PointsWidgetPage(
                            points: 8888,
                            items: 9999,
                          ),
                          const SizedBox(height: 30),
                          MenuOptionWidget(
                            icon: Icons.star,
                            title: 'Reportes',
                            iconColor: Colors.green,
                          ),
                          MenuOptionWidget(
                            icon: Icons.lock,
                            title: 'Cambio de contraseña',
                            iconColor: Colors.grey,
                          ),
                          MenuOptionWidget(
                            icon: Icons.notifications,
                            title: 'Notificaciones al correo',
                            iconColor: Colors.grey,
                          ),
                          MenuOptionWidget(
                            icon: Icons.emoji_events,
                            title: 'Insignias',
                            iconColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
