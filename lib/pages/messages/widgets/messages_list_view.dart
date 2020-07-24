import 'package:flutter/material.dart';

import 'package:identitic/pages/messages/widgets/room_list_tile.dart';

class MessagesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: 10,
      separatorBuilder: (_, int i) {
        return SizedBox(height: 8);
      },
      itemBuilder: (_, int i) {
        return RoomListTile();
      },
    );
  }
}
