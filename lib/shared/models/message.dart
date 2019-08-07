class IChatMessage implements Comparable<IChatMessage> {
  final String id;
  final String body;
  final int createdAt;
  final String userId;

  IChatMessage({this.id, this.body, this.createdAt, this.userId});

  int compareTo(IChatMessage other) {
    return -createdAt.compareTo(other.createdAt);
  }
}
