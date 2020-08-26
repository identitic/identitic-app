class PNotification {
  final String body;
  final String title;

  PNotification({this.body, this.title});

  factory PNotification.fromJson(Map<String, dynamic> json) {
    return PNotification(
      title: json['title'], 
      body: json['body']
    );
  }
}
