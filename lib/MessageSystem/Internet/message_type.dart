//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum MessageType {
  ping(id: 0),
  pong(id: 1),
  normalMessage(id: 2),
  ;
  final int id;
  const MessageType({required this.id});
  static MessageType fromId(int id)
  {
    return MessageType.values.firstWhere((e) => e.id == id);
  }
}