import 'package:flutter/material.dart';
import 'package:ecogo/core/components/app_drawer.dart';

class SettingsPage extends StatefulWidget { // Corrige el nombre a SettingsPage
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  
  // Lista de imágenes de avatares
  final List<String> avatarImages = [
    'lib/core/assets/face-1.png',
    'lib/core/assets/face-2.png',
    'lib/core/assets/face-3.png',
    'lib/core/assets/face-4.png',
    'lib/core/assets/face-5.jpg',
    'lib/core/assets/face-6.jpg',
    'lib/core/assets/face-7.png',
    'lib/core/assets/face-8.png',
  ];

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
                Color.fromARGB(192, 32, 144, 209),
                Color.fromARGB(192, 29, 138, 201),
                Color.fromARGB(228, 37, 163, 185),
                Color.fromARGB(174, 23, 155, 115),
                Color.fromARGB(143, 30, 170, 49),
                Color.fromARGB(137, 101, 211, 57),
                Color.fromARGB(127, 111, 172, 32),
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
                    IconButton(
                      icon: const Icon(Icons.menu),
                      color: const Color.fromARGB(255, 238, 238, 238),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, color: Colors.amber),
                        const SizedBox(width: 5),
                        const Text(
                          '300',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 238, 238, 238),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Expanded(
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
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ajustes de Perfil',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Campo para cambiar el nombre de usuario
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Cambiar apodo/nombre de usuario',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () {
                                  String newUsername = _usernameController.text;
                                  print('Nuevo nombre de usuario: $newUsername');
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Selecciona un avatar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16.0),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: avatarImages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print('Seleccionaste el avatar: ${avatarImages[index]}');
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      avatarImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                          Positioned(
                              bottom: 20,
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
                                      'Guardar',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    backgroundColor: const Color.fromARGB(255, 49, 157, 207),
                                  ),
                                ),
                              ),
                            ),

                             const SizedBox(height: 30),
                        
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
