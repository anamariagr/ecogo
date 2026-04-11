// models/post.dart

class Post {
  final String title;
  final String description;
  final String category;
  final String content;
  final String image;
  final String createdAt;

  Post({
    required this.title,
    required this.description,
    required this.category,
    required this.content,
    required this.image,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      content: json['content'],
      image: json['image'],
      createdAt: json['created_at'],
    );
  }
}
