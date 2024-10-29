import 'package:flutter/material.dart';
import 'package:ecogo/app/ecogo/views/dashboard/widgets/indicator.dart';
import 'package:ecogo/app/ecogo/views/news/news_page.dart';
import 'package:ecogo/app/ecogo/views/reports/reports_page.dart';
import 'package:ecogo/app/ecogo/views/ranking/ranking_page.dart';
//import 'package:ecogo/app/ecogo/views/profile/profile_page.dart';
import 'package:ecogo/app/ecogo/views/setings/setings_page.dart';
import 'package:ecogo/login/register_page.dart';
import 'package:ecogo/login/login_page.dart'; // Importa tu página de login
import 'package:ecogo/app/ecogo/views/dashboard/widgets/cards_materials.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: const <Widget>[
              InicioPage(),
              ReportsPage(),
              RankingPage(),
              //NewsPage(),
              SettingsPage(),
              //ProfilePage(),
              //RegisterPage(),
              //LoginPage(),
            ],
          ),
          if (_selectedIndex != 3 && _selectedIndex != 5)
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      // Acción para el botón "Reportar Vertedero"
                    },
                    label: const Text(
                      'Reportar Vertedero',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    backgroundColor: const Color.fromARGB(255, 49, 157, 207),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  },
  unselectedItemColor: Colors.grey,
  selectedItemColor: Color.fromARGB(255, 124, 192, 68),
  iconSize: 30,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Inicio',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star_half_rounded),
      label: 'Reportes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.leaderboard_outlined),
      label: 'Ranking',
    ),
  //  BottomNavigationBarItem(
   //   icon: Icon(Icons.book_online_sharp),
   //   label: 'Noticias',
   // ),
    BottomNavigationBarItem(
     icon: Icon(Icons.settings),
     label: 'Ajustes',
    ),
 //   BottomNavigationBarItem(
   //   icon: Icon(Icons.person),
    //  label: 'Registro',
   // ),
    //BottomNavigationBarItem(
    //  icon: Icon(Icons.login),
     // label: 'Login',
   // ),
  ],
),

    );
  }
}

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
               
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                              Color.fromARGB(192, 32, 144, 209),
                           Color.fromARGB(192, 29, 138, 201),
                          Color.fromARGB(228, 37, 163, 185),
                          Color.fromARGB(174, 23, 155, 115),
                            Color.fromARGB(137, 30, 170, 49),
                          Color.fromARGB(132, 101, 211, 57),
                          Color.fromARGB(113, 111, 172, 32),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 30, left: 10, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                width: 5.0,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('lib/core/assets/face-1.png'),
                              radius: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 60.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(240, 195, 253, 208),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: Color.fromARGB(255, 48, 49, 48),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 20),
                        const Text(
                          'Hemos logrado',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Indicator(
                              indicator:'Reportes',
                              icon: Icons.energy_savings_leaf_rounded,
                              col: Colors.blue,
                              value: '500',
                              label: 'Vertederos',
                            ),
                            Indicator(
                              indicator:'Recoleccion',
                              icon: Icons.cloud_done_sharp,
                              col: Color.fromARGB(255, 175, 31, 211),
                              value: '5.2 kg',
                              label: 'Residuos',
                            ),
                            Indicator(
                              indicator:'Reciclaje',
                              col: Colors.green,
                              icon: Icons.recycling,
                              value: '2000kg',
                              label: 'Residuos',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 8, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Lo que Encontramos',
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Ver todo',
                            style: TextStyle(
                              color: Color.fromARGB(255, 59, 59, 59),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:
                        150, // Establece una altura específica para el GridView
                    child: GridView.count(
                      scrollDirection: Axis
                          .horizontal, // Habilita el desplazamiento horizontal
                      crossAxisCount:
                          1, // Una sola fila para organizar horizontalmente
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10),
                      physics:
                          const ScrollPhysics(), // Habilita el desplazamiento
                      children: const [
                        CardsMaterials(
                          imageUrl: 'lib/core/assets/plastic.png',
                          textOnImage: 'Plásticos',
                          title: '',
                        ),
                        CardsMaterials(
                          imageUrl: 'lib/core/assets/paper.png',
                          title: '',
                          textOnImage: 'Cartón y Papel',
                        ),
                        CardsMaterials(
                          imageUrl: 'lib/core/assets/glass.png',
                          title: '',
                          textOnImage: 'Eléctricos',
                        ),
                        CardsMaterials(
                          imageUrl: 'lib/core/assets/paper.png',
                          title: '',
                          textOnImage: 'Chatarra',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vertederos Reportados',
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Ver todo',
                            style: TextStyle(
                              color: Color.fromARGB(255, 59, 59, 59),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 200,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('lib/core/assets/map.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                   const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
