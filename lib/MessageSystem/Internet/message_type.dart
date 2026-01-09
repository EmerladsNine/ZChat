//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum MessageType {
  ping(id: 0,hasBody: false),
  pong(id: 1,hasBody: false),
  normalMessage(id: 2,hasBody: true),
  ;
  final int id;
  final bool hasBody;
  const MessageType({required this.id,required this.hasBody});
  static MessageType fromId(int id)
  {
    return MessageType.values.firstWhere((e) => e.id == id);
  }
}