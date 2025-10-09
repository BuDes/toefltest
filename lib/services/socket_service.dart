import 'dart:developer';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:toeflapp/services/api_service.dart';

class SocketService {
  late IO.Socket socket;

  Function(Map<String, dynamic> json)? onReceivemessage;

  void connect(id) {
    socket = IO.io(
      ApiService.hostUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'userId': id})
          .setAckTimeout(20000)
          .build(),
    );

    socket.onConnect((_) {
      log('Connected to socket with userId: $id');
    });

    socket.on("receive_message", (data) {
      onReceivemessage?.call(data);
    });

    socket.onDisconnect((_) => log('Socket Disconnected'));
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void createMessage(
    int idPenerima,
    String content,
    Function(Map<String, dynamic>) callback,
  ) async {
    final data = await socket.emitWithAckAsync("send_message", {
      "to_user_id": idPenerima,
      "content": content,
    });
    callback(data);
  }
}
