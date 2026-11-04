class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> j) => Post(
        id: j['id'],
        userId: j['userId'],
        title: j['title'],
        body: j['body'],
      );
}