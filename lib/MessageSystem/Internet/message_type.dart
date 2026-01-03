enum MessageType {
  ping(0),
  pong(1),
  normalMessage(2),
  ;
  final int id;
  const MessageType(this.id);
}