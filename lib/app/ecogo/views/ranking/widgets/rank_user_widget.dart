import 'package:ecogo/core/models/ranking.dart';
import 'package:flutter/material.dart';

class RankUserWidget extends StatelessWidget {
  final RankingUser user; // Use RankingUser model instead of Map
  final double avatarSize;
  final Color borderColor;
  final int position;

  const RankUserWidget({
    Key? key,
    required this.user,
    required this.avatarSize,
    required this.borderColor,
    required this.position
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 5),
          ),
          child: CircleAvatar(
            backgroundImage: user.profilePhoto != null && user.profilePhoto!.startsWith('http')
                ? NetworkImage(user.profilePhoto!)
                : AssetImage(user.profilePhoto ?? 'lib/core/assets/default-avatar.png')
            as ImageProvider,
            radius: avatarSize,
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: borderColor.withOpacity(0.2),
            ),
            child: Text(
              "${this.position}",
              style: const TextStyle(
                color: Color.fromARGB(255, 85, 85, 85),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
