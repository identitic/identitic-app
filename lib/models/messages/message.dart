class Message {
  Message({
    this.content,
    this.senderID,
    this.receiverID,
  });

  final String content;
  final String senderID; 
  final String receiverID; 

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'], //Parse
      senderID: json['sender_id'], 
      receiverID: json['receiver_id']
    );
  }
}
