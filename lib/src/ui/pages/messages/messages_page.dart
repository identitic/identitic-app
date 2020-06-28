import 'package:flutter/material.dart';
import 'package:identitic/src/providers/auth_provider.dart';

import 'package:provider/provider.dart';

import 'package:identitic/src/models/messages/room.dart';
import 'package:identitic/src/providers/sockets_provider.dart';
import 'package:identitic/src/ui/pages/messages/widgets/room_list_tile.dart';
import 'package:identitic/src/ui/widgets/identitic_button.dart';
import 'package:identitic/src/utils/constants.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mensajes'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 16),
            IdentiticButton(
                onPressed: () => Navigator.pushNamed(context, RouteName.room),
                child: Text("Nuevo mensaje")),
            SizedBox(height: 16),
            FutureBuilder(
                future: Provider.of<SocketsProvider>(context, listen: false)
                    .fetchRooms(
                        Provider.of<AuthProvider>(context, listen: false)
                            .user
                            .id),
                builder: (_, AsyncSnapshot<List<Room>> snapshot) {
                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 1,
                    separatorBuilder: (_, int i) => SizedBox(height: 8),
                    itemBuilder: (_, int i) {
                      if (i == 0) {
                        return Column(children: [
                          ListTile(
                            title: Text('Mensajes'),
                          ),
                          RoomListTile()
                        ]);
                      }
                      return RoomListTile();
                    },
                  );
                }
                ),
          ],
        ));
  }
}
