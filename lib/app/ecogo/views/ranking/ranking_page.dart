import 'package:flutter/material.dart';
import 'package:ecogo/core/components/app_drawer.dart';
import 'package:ecogo/app/ecogo/views/ranking/widgets/rank_user_widget.dart';  

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    final List<Map<String, dynamic>> topUsers = [
      {'name': 'Sarah', 'position': 1, 'image': 'lib/core/assets/face-2.png'},
      {'name': 'Thomas', 'position': 2, 'image': 'lib/core/assets/face-1.png'},
      {'name': 'Sandy', 'position': 3, 'image': 'lib/core/assets/face-3.png'},
    ];

    final List<Map<String, dynamic>> otherUsers = [
      {
        'name': 'Sebastian',
        'rank': '#10',
        'score': 1124,
        'position': 10,
        'items': 180,
        'image': 'lib/core/assets/face-6.jpg'
      },
      {
        'name': 'Jason',
        'rank': '#11',
        'score': 875,
        'position': 20,
        'items': 120,
        'image': 'lib/core/assets/face-5.jpg'
      },
      {
        'name': 'Sebastian',
        'rank': '#10',
        'score': 1124,
        'position': 10,
        'items': 180,
        'image': 'lib/core/assets/face-6.jpg'
      },
      {
        'name': 'Jason',
        'rank': '#11',
        'score': 875,
        'position': 20,
        'items': 120,
        'image': 'lib/core/assets/face-5.jpg'
      },
    ];

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
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          color: const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
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
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ranking',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Hoy',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                'Esta semana',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                'Todo el tiempo',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.tune, color: Colors.green),
                                onPressed: () {
                                  // Acción para el botón de ajustes
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Los tres primeros puestos con el usuario #1 en el centro
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RankUserWidget(
                              user: topUsers[1],
                              avatarSize: 40,
                              borderColor: Colors.blue,
                            ),
                            Stack(
                              children: [
                                RankUserWidget(
                                  user: topUsers[0],
                                  avatarSize: 60,
                                  borderColor: Colors.amber,
                                ),
                                Positioned(
                                  top: -13,
                                  left: 0,
                                  right: 0,
                                  child: IgnorePointer(
                                    child: Image.asset(
                                      'lib/core/assets/crown.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            RankUserWidget(
                              user: topUsers[2],
                              avatarSize: 40,
                              borderColor: const Color.fromARGB(255, 244, 92, 54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Lista de otros usuarios
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            itemCount: otherUsers.length,
                            itemBuilder: (context, index) {
                              final user = otherUsers[index];
                              return Card(
                                color: const Color.fromARGB(255, 233, 252, 235),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '#${user['position']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(user['image']),
                                        radius: 25,
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    user['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${user['items']} Items',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  trailing: Text(
                                    '${user['score']}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 244, 114, 54),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
