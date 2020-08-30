class PushNotification {
  final String body;
  final String title;
  final int id;

  PushNotification({this.body, this.title, this.id});

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return PushNotification(
      title: json['title'], 
      body: json['body'],
      id: json['data']['id_event']
    );
  }
}
