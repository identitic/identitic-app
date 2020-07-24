class Room {
  Room({
    this.idRoom,
    this.sender,
    this.receiver,
    this.lastMessage
  });

  final int idRoom;
  final String sender;
  final String receiver;
  final String lastMessage;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      sender: json['senderChatID'],
      receiver: json['receiverChatID'],
      idRoom: json['id_room'],
      lastMessage: json['last_message']
    );
  }
}
