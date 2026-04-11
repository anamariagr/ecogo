import 'package:ecogo/app/ecogo/controllers/avatar_controller.dart';
import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:ecogo/core/models/avatar.dart';
import 'package:flutter/material.dart';
import 'package:ecogo/core/components/app_drawer.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserController userController = Get.find();
  final AvatarController avatarController = Get.find();

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      drawer: AppDrawer(pageController: pageController),
      body: Stack(
        children: [
          Column(
            children: [
              // Top Bar
              Container(
                decoration: const BoxDecoration(
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
                child: Padding(
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
              ),
              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: userController.usernameController.value,
                            decoration: InputDecoration(
                              labelText: 'Cambiar apodo/nombre de usuario',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () {
                                  String newUsername = userController.usernameController.value.text;
                                  print('Nuevo nombre de usuario: $newUsername');
                                  // Add logic to update the username
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
                        // Avatar Grid
                        Expanded(
                          child: Obx(() {
                            return GridView.builder(
                              padding: const EdgeInsets.only(top: 16, bottom: 150, left: 16, right: 16),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: avatarController.avatars.length,
                              itemBuilder: (context, index) {
                                Avatar avatar = avatarController.avatars[index];
                                return AvatarGridItem(
                                  avatar: avatar,
                                  userController: userController,
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Save Button
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 300,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // Action for the "Guardar" button
                    print('Avatar seleccionado: ${userController.selectedAvatarRx.value}');
                    userController.updateUserProfile();

                    // Add logic to save the selected avatar
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
        ],
      ),
    );
  }
}

class AvatarGridItem extends StatelessWidget {
  final Avatar avatar;
  final UserController userController;

  AvatarGridItem({
    required this.avatar,
    required this.userController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        userController.selectedAvatarRx.value = avatar.imageUrl;
        print('Seleccionaste el avatar: ${avatar.imageUrl}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: userController.selectedAvatarRx.value == avatar.imageUrl
                ? Colors.blue
                : Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              avatar.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    ));
  }
}
