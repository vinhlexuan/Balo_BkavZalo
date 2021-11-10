class Post {
  final String profileImageUrl;
  final String username;
  final String time;
  final String content;
  final String likes;
  final String comments;
  final String shares;

  Post(
      {required this.profileImageUrl,
      required this.username,
      required this.time,
      required this.content,
      required this.likes,
      required this.comments,
      required this.shares});
}
