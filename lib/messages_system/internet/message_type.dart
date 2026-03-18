//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum MessageType {
  ping(id: 0),
  pong(id: 1),
  normalMessage(id: 2),
  emailSignIn(id: 3),
  emailSignUp(id: 4),
  authResponseCode(id: 5),
  googleSignIn(id: 6),
  googleSignUp(id: 7),
  searchWithUsername(id: 8),
  searchWithId(id: 9),
  searchResponseCode(id: 10),
  normalMessageResponseCode(id: 11),
  sessionStateResponseCode(id: 12),
  useAccessToken(id: 13),
  useRefreshToken(id: 14);

  final int id;
  const MessageType({required this.id});
  static MessageType fromId(int id) {
    return MessageType.values.firstWhere((e) => e.id == id);
  }
}
