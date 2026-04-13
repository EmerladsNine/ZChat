//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum MessageResponseCode {
  unknown(id: -1),
  failure(id: 0),
  success(id: 1),
  outdatedSessionListVersion(id: 2),
  userNotFound(id: 3);

  final int id;
  const MessageResponseCode({required this.id});
  static MessageResponseCode fromId(int id) {
    return MessageResponseCode.values.firstWhere(
          (e) => e.id == id,
      orElse: () => MessageResponseCode.unknown,
    );
  }
}
