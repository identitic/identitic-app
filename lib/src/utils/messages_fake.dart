import 'package:identitic/src/models/messages/message.dart';
import 'package:identitic/src/models/user.dart';

List<User> users = [
    User(id: 1, name: 'Julian', lastName: 'Sanchez', hierarchy: UserHierarchy.student),
    User(id: 2, name: 'Julian', lastName: 'Sanchez', hierarchy: UserHierarchy.student),
    User(id: 3, name: 'Julian', lastName: 'Sanchez', hierarchy: UserHierarchy.student),
    User(id: 4, name: 'Julian', lastName: 'Sanchez', hierarchy: UserHierarchy.student),
    User(id: 5, name: 'Julian', lastName: 'Sanchez', hierarchy: UserHierarchy.student),
  ];

  User currentUser = users[0];

  List<User> friendList = List<User>();
  List<Message> messages = List<Message>();
  