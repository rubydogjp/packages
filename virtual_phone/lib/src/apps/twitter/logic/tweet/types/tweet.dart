class Tweet {
  const Tweet({
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  final String userId;
  final String text;
  final String createdAt;
}
