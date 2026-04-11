// models/report.dart

class Report {
  final int id;
  final int userId;
  final String latitude;
  final String longitude;
  final String address;
  final String comment;
  final String status;
  final String? imageUrl; // Si los reportes pueden incluir imágenes opcionales

  Report({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.comment,
    required this.status,
    this.imageUrl,
  });

  factory Report.fromJson(Map<String, dynamic> json) {

     return Report(
      id: json['id'],
      userId: json['user_id'],
      latitude: "${json['latitude']}",
      longitude: "${json['longitude']}",
      address: json['address'],
      comment: json['comment'],
      status: json['status'],
      imageUrl: json['images'],
    );
  }
}
