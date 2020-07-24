import 'package:flutter/material.dart';
import 'package:identitic/models/messages/message.dart';

import 'package:identitic/models/messages/room.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/sockets_provider.dart';
import 'package:identitic/widgets/theme.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  const RoomPage(this.room);

  final Room room;

  @override
  _RoomPageCreateState createState() => _RoomPageCreateState();
}

class _RoomPageCreateState extends State<RoomPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.room?.receiver ?? 'Chat'), centerTitle: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: buildChatList(),
            ),
            buildChatArea()
          ],
        ),
      ),
    );
  }

  Widget buildChatArea() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.only(left: 28),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration:
                  InputDecoration.collapsed(hintText: 'Escribí un mensaje...'),
              controller: textEditingController,
            ),
          ),
          SizedBox(width: 16),
          IconButton(
            onPressed: () {
              _sendMessage(context);
            },
            icon: Icon(Icons.send),
            color: Colors.pink,
          )
        ],
      ),
    );
  }

  Widget buildChatList() {
/*     return FutureBuilder(
        future: Provider.of<SocketsProvider>(context, listen: true).fetchMessages(
                Provider.of<AuthProvider>(context, listen: false).user.id),
        builder: (_, AsyncSnapshot<List<Message>> snapshot) {
          final List<Message> messages = snapshot.data; */
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: Provider.of<SocketsProvider>(context, listen: false)
              .fakeMessages
              ?.length ??
          10,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(top: 15.0),
      itemBuilder: (_, int i) {
        final List<Message> list = List.from(
            Provider.of<SocketsProvider>(context, listen: false)
                .fakeMessages
                .reversed);
        final Message message = list[i];
        final bool isMe = message.senderID != "1";
        return buildSingleMessage(message, isMe);
      },
    );
  }
  /* return Container(width: 0, height: 0,); */
  /*  ); */

  Widget buildSingleMessage(Message message, bool isMe) {
    return Container(
      alignment: /* message.senderID == widget.room.receiver */
          isMe ? Alignment.centerLeft : Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0),
      decoration: BoxDecoration(
          borderRadius: isMe
              ? BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0)),
          color: isMe ? Colors.deepPurpleAccent : Colors.pink),
      child: Column(
        children: <Widget>[
          Text(
            '16:20',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            message.content,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(context) {
    Provider.of<SocketsProvider>(context, listen: false).sendMessage(
        textEditingController.text,
        Provider.of<AuthProvider>(context, listen: false).user.id.toString(),
        widget.room.receiver,
        DateTime.now().toUtc().toString());

    Provider.of<SocketsProvider>(context, listen: false).fakeMessages.add(
        Message(
            content: textEditingController.text,
            senderID: "1",
            receiverID: "2"));
    textEditingController.text = '';
    textEditingController.clear();
  }
}
