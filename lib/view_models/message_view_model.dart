import 'package:flutter/material.dart';
import 'package:toeflapp/services/socket_service.dart';

class MessageViewModel extends ChangeNotifier {
  SocketService? _socketService;
  SocketService? get socketService => _socketService;

  set socketService(SocketService? service) {
    _socketService = service;
    _socketService?.onReceivemessage = _receiveMessage;
  }

  void _receiveMessage(Map<String, dynamic> json) async {
    // TODO: handle receive message
    // final pesan = PesanModel.fromJson(json).toMap();
    // TODO: save pesan to db
    // await _dbService.savePesan([pesan]);
    // TODO: get pesan from db
    // await _loadPesan();
  }
}
