class MaterialItem {
  final String title;
  final String description;
  final String image;

  MaterialItem({
    required this.title,
    required this.description,
    required this.image,
  });

  // Factory method to parse JSON into a MaterialItem object
  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
