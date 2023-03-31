class Issue {
  final int id;
  final String title;
  final String author;
  final String authorAvatarUrl;
  final DateTime createdAt;
  final int commentsCount;
  final String state;

  Issue({
    required this.id,
    required this.title,
    required this.author,
    required this.authorAvatarUrl,
    required this.createdAt,
    required this.commentsCount,
    required this.state,
  });
}