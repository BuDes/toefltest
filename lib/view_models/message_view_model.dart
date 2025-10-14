import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toeflapp/models/chat_room_preview.dart';
import 'package:toeflapp/models/message.dart';
import 'package:toeflapp/models/user.dart';
import 'package:toeflapp/services/api_service.dart';
import 'package:toeflapp/services/database_service.dart';
import 'package:toeflapp/services/socket_service.dart';

class MessageViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/message";
  final _dbService = DatabaseService();

  SocketService? _socketService;
  List<ChatMessage> _listPesan = [];
  List<ChatRoomPreview> _listPreviews = [];

  SocketService? get socketService => _socketService;
  List<ChatRoomPreview> get listPreviews => _listPreviews;
  List<ChatMessage> get listPesan => _listPesan;

  set socketService(SocketService? service) {
    _socketService = service;
    _socketService?.onReceivemessage = _receiveMessage;
  }

  List<ChatMessage> getPesanByUser(String id) {
    return _listPesan.where((pesan) {
      return pesan.idPenerima == id || pesan.idPengirim == id;
    }).toList();
  }

  Future<List<ChatMessage>> getPesan() async {
    try {
      final response = await ApiService.getRequest(_endpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        final listPesanMasuk = json.map((e) {
          return ChatMessage.fromJson(e).toMap();
        }).toList();
        final listUser = json.map((e) {
          return User.fromJson(e["fromUser"]).toMap();
        }).toList();
        await _dbService.saveUsers(listUser);
        await _dbService.savePesan(listPesanMasuk);
        await _loadPesan();
        return _listPesan;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to get messages: $e", stackTrace: stacktrace);
    }
    return _listPesan;
  }

  Future<List<ChatRoomPreview>> getChatroomPreviews() async {
    final listUsers = await _getUsers();
    await getPesan();
    _listPreviews = _chatroomPreviewsFromUsers(listUsers);
    notifyListeners();
    return _listPreviews;
  }

  Future createMessage(ChatMessage pesan) async {
    _listPesan.insert(0, pesan);
    notifyListeners();

    socketService!.createMessage(pesan.idPenerima, pesan.isi, (response) async {
      if (response["status"]) {
        pesan.id = response["id"];
        pesan.status = StatusPesan.dikirim;
        // _listPesan[index].id = response["id"];
        // _listPesan[index].status = StatusPesan.dikirim;
        // _listPesan[index] = pesan.copy(
        //   id: response["id"],
        //   status: StatusPesan.dikirim,
        // );
        await _dbService.savePesan([pesan.toMap()]);
        await _reGetChatroomPreviews();
        notifyListeners();
      }
    });
  }

  Future<List<User>> getPakar() async {
    try {
      const endpoint = "${ApiService.baseUrl}/user/pakar";
      final response = await ApiService.getRequest(endpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        final listUsers = json.map((e) => User.fromJson(e)).toList();
        return listUsers;
      }
    } catch (e, stacktrace) {
      log("Failed to get pakar: $e", stackTrace: stacktrace);
    }
    return [];
  }

  Future readPesan(String idPengirim) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final count = await _dbService.readPesan(idPengirim, time);
    if (count > 0) await _loadPesan();
  }

  Future clearDataPesan() async {
    await Future.wait([
      _dbService.clearPesan(),
      _dbService.clearUsers(),
    ]);
  }

  void _receiveMessage(Map<String, dynamic> json) async {
    final user = User.fromJson(json["fromUser"]).toMap();
    final pesan = ChatMessage.fromJson(json).toMap();
    await _dbService.savePesan([pesan]);
    await _dbService.saveUsers([user]);
    await _loadPesan();
  }

  Future<List<ChatRoomPreview>> _reGetChatroomPreviews() async {
    final usersMap = await _dbService.getUsers();
    final pesanMap = await _dbService.getPesan();
    _listPesan = pesanMap.map((pesan) {
      return ChatMessage.fromDatabase(pesan);
    }).toList();
    final listUsers = usersMap.map((user) => User.fromDatabase(user)).toList();
    _listPreviews = _chatroomPreviewsFromUsers(listUsers);
    notifyListeners();
    return _listPreviews;
  }

  Future<List<User>> _getUsers() async {
    final usersMap = await _dbService.getUsers();
    final listUsers = usersMap.map((user) {
      return User.fromDatabase(user);
    }).toList();
    return listUsers;
  }

  Future<List<ChatMessage>> _loadPesan() async {
    try {
      final pesanMap = await _dbService.getPesan();
      _listPesan = pesanMap
          .map((pesan) => ChatMessage.fromDatabase(pesan))
          .toList();
      await _reGetChatroomPreviews();
      notifyListeners();
    } catch (e, stacktrace) {
      log("Failed to load pesan: $e", stackTrace: stacktrace);
    }
    return _listPesan;
  }

  List<ChatRoomPreview> _chatroomPreviewsFromUsers(List<User> listUsers) {
    return listUsers.map((user) {
      final pesanTerakhir = _listPesan.where((pesan) {
        return pesan.idPenerima == user.id || pesan.idPengirim == user.id;
      }).firstOrNull;
      return ChatRoomPreview(
        oppose: user,
        pesanTerakhir: pesanTerakhir?.isi,
        isTerakhirKirim: pesanTerakhir?.idPenerima == user.id,
        tglPesan: pesanTerakhir?.waktuKirim,
        tglBaca:
            pesanTerakhir?.tglBaca ??
            (user.id == pesanTerakhir?.idPenerima ? DateTime.now() : null),
      );
    }).toList();
  }
}
