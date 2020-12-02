class Grade {
  Grade({
    this.idUser,
    this.subject,
    this.value,
    this.term,
  });

  final int idUser;
  final String subject;
  dynamic value;
  final dynamic term;

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      subject: json['ds_subject'],
      value: int.parse(json['mark']),
      term: json['term'],
    );
  }
}
