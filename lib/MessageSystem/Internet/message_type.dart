//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum MessageType {
  ping(0),
  pong(1),
  normalMessage(2),
  ;
  final int id;
  const MessageType(this.id);
}