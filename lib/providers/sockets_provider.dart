import 'package:flutter/cupertino.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:identitic/models/messages/message.dart';
import 'package:identitic/models/messages/room.dart';
import 'dart:convert';

import 'package:identitic/models/user.dart';
import 'package:identitic/services/messages_service.dart';

class SocketsProvider extends ChangeNotifier {
  SocketsProvider() {
    fetchRooms();
  }
  List<User> _users = [
    User(
        id: 1,
        hierarchy: UserHierarchy.student,
        name: 'Nahuel',
        lastName: 'Rodríguez'),
    User(
        id: 2,
        hierarchy: UserHierarchy.student,
        name: 'Fernando',
        lastName: 'Pérez'),
    User(
        id: 3,
        hierarchy: UserHierarchy.student,
        name: 'Matías',
        lastName: 'Sánchez'),
    User(
        id: 8,
        hierarchy: UserHierarchy.teacher,
        name: 'Sergio',
        lastName: 'López')
  ];

  List<Message> _fakemessages = [
    Message(content: 'Hola Profe!', senderID: '1', receiverID: '5'),
    Message(
        content: 'Quería saber si la entrega del TP es flexible',
        senderID: '1',
        receiverID: '5'),
    Message(content: 'No.', senderID: '5', receiverID: '1'),
    Message(content: 'Hola Profe!', senderID: '1', receiverID: '5'),
    Message(
        content: 'Quería saber si la entrega del TP es flexible',
        senderID: '1',
        receiverID: '5'),
    Message(content: 'No.', senderID: '5', receiverID: '1'),
  ];

  User currentUser;
  List<User> friendsList = List<User>();
  List<Room> fakeRooms = [];

  MessagesService _messagesService = MessagesService();

  List<Message> get fakeMessages => _fakemessages;

  List<Message> _messages;
  List<Message> get messages => _messages;
  List<Room> _rooms;
  List<Room> get rooms => _rooms;

  List<User> get users => _users;

  SocketIO socketIO;

  void init(int idUser) {
    currentUser = users[0];
    friendsList = users.where((user) => user.id != currentUser.id).toList();
    socketIO = SocketIOManager().createSocketIO(
        'http://35.211.3.86:3000', '/sockets',
        query:
            'chatID=$idUser'); /* Provider.of<AuthProvider>(context,listen:false).user.id.toString() */
    socketIO.init();
    debugPrint('socket inicio xd');

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          content: data['content'],
          receiverID: data['senderChatID'],
          senderID: data['receiverChatID']));
      notifyListeners();
    });

    socketIO.connect();
  }

  void sendMessage(
      String text, String senderChatID, String receiverChatID, String date) {
    messages.add(Message(
        content: text, senderID: senderChatID, receiverID: receiverChatID));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': currentUser.id.toString(),
        'content': text,
        'date': date
      }),
    );

    fakeMessages.add(Message(
        content: text, senderID: senderChatID, receiverID: receiverChatID));

    notifyListeners();
  }

  Future<List<Message>> fetchMessages(int idUser) async {
    try {
      _messages = await _messagesService.fetchMessages(idUser);
      notifyListeners();
      return _messages;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Room>> fetchRooms() async {
    try {
      _rooms = await _messagesService.fetchRooms();
      notifyListeners();
      return _rooms;
    } catch (e) {
      rethrow;
    }
  }
}
