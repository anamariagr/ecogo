import 'package:ecogo/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserGreetingWidget extends StatelessWidget {
  final Rx<User?> user;
  final bool isAuthorized;
  final VoidCallback onRegisterTap;
  final Future<void> Function() onSignOut;

    UserGreetingWidget({
    Key? key,
    required this.user,
    required this.isAuthorized,
    required this.onRegisterTap,
    required this.onSignOut,
  }) : super(key: key);
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {

    final isLoggedIn = GetStorage().read('isLoggedIn') ?? false;

    return Row(
      children: [
        // Avatar del usuario
        Container(
          margin: const EdgeInsets.only(left: 10, right: 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 5.0,
            ),
          ),
          child: Obx(() {
            User? currentUser = user.value;
            return CircleAvatar(
              backgroundImage: currentUser?.profilePhoto != null
                  ? NetworkImage(currentUser!.profilePhoto!)
                  : const AssetImage('lib/core/assets/face-1.png')
              as ImageProvider,
              radius: 30,
            );
          }),
        ),
        const SizedBox(width: 10),
        // Contenedor de saludo o registro
        Expanded(
          child: GestureDetector(
            onTap: !isLoggedIn ? onRegisterTap : null,
            child: Container(
              padding: EdgeInsets.only(top:  isAuthorized ? 5 : 15, bottom: isAuthorized ? 5 : 15,left: 10,right: 10),
               decoration: BoxDecoration(
                color: const Color.fromARGB(240, 195, 253, 208),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        user.value != null
                            ? 'Hola, ${user.value?.name?.split(" ").first}'
                            : 'Regístrate',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 48, 49, 48),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Botón de cerrar sesión
                    if (user.value != null)
                      IconButton(

                        icon: const Icon(Icons.logout, color: Colors.black),
                        onPressed: () async {
                          await onSignOut();
                        },
                        tooltip: 'Cerrar sesión',
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
