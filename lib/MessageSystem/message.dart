class Message {
  Message({this.text,this.timestamp = 0,this.fromMe = false,this.senderId});
  String? text;
  int timestamp;
  bool fromMe;
  int? senderId;
}