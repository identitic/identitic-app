import 'package:flutter/material.dart';

import 'package:identitic/models/messages/room.dart';
import 'package:identitic/utils/constants.dart';

class RoomListTile extends StatelessWidget {
  const RoomListTile([this.room]);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.pink,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
      ),
      title: Text(room?.receiver ?? 'Fernando Lopez'),
      subtitle: Text(room?.lastMessage ?? 'Hola, como estás?'),
      trailing: Icon(Icons.chevron_right),
      onTap: () =>
          Navigator.pushNamed(context, RouteName.room, arguments: this.room),
    );
  }
}
