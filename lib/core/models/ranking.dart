// models/ranking_user.dart

class RankingUser {
  final int userId;
  final String name;
  final String? profilePhoto;
  final int reportCount;

  RankingUser({
    required this.userId,
    required this.name,
    required this.profilePhoto,
    required this.reportCount,
  });

  // Factory constructor to create a RankingUser instance from JSON
  factory RankingUser.fromJson(Map<String, dynamic> json) {
    return RankingUser(
      userId: json['user_id'],
      name: json['name'],
      profilePhoto: json['profile_photo'],
      reportCount: json['report_count'],
    );
  }
}
