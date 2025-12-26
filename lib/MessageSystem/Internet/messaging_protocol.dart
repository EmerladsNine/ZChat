import 'dart:io';
import 'dart:convert';

Future<void> SendMessage(String message) async {
  final String host = "92.113.26.192";
  final int port = 9999;

  try {
    final Socket socket = await Socket.connect(host, port);
    print('Connected to $host:$port');

    socket.listen((data) {
      final String repsonse = utf8.decode(data);
      print('Server: $repsonse');
    },);
    socket.write('$message\n');
    print('sent: $message');

    await Future.delayed(Duration(seconds: 5));
    socket.close();
  } catch (e) {
    print(e);
  }
}
