import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecogo/core/components/app_drawer.dart';
import 'package:ecogo/app/ecogo/views/ranking/widgets/rank_user_widget.dart';
import 'package:ecogo/app/ecogo/controllers/ranking_controller.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final RankingController controller = Get.find();

    return Scaffold(
      drawer: AppDrawer(pageController: pageController),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final topUsers = controller.ranking.take(3).toList();
        final otherUsers = controller.ranking.length > 3
            ? controller.ranking.skip(3).toList()
            : [];

        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
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
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 20),
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
                    // Other UI components
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Top Users Display
                  if (topUsers.isNotEmpty)
                    Row(
                      mainAxisAlignment: topUsers.length == 1
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (topUsers.length > 1)
                          RankUserWidget(
                            user: topUsers[1],
                            avatarSize: 40,
                            borderColor: Colors.blue,
                            position: 2
                          ),
                        if (topUsers.isNotEmpty)
                          Stack(
                            children: [
                              RankUserWidget(
                                user: topUsers[0],
                                avatarSize: 60,
                                borderColor: Colors.amber,
                                  position: 1

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
                        if (topUsers.length > 2)
                          RankUserWidget(
                            user: topUsers[2],
                            avatarSize: 40,
                            borderColor: const Color.fromARGB(255, 244, 92, 54),
                              position: 3

                          ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  // Other Users List
                  if (otherUsers.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(bottom: 80), // Add bottom padding here
                        itemCount: otherUsers.length,
                        itemBuilder: (context, index) {
                          final user = otherUsers[index];
                          return Card(
                            color: const Color.fromARGB(255, 233, 252, 235),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: user.profilePhoto != null
                                    ? NetworkImage(user.profilePhoto!)
                                    : const AssetImage('lib/core/assets/default-avatar.png') as ImageProvider,
                                radius: 25,
                              ),
                              title: Text(
                                user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                '${user.reportCount} Reportes',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              trailing: Text(
                                '${user.reportCount}',
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
          ],
        );
      }),
    );
  }
}
