class Grade {
  Grade({
    this.idUser,
    this.subject,
    this.value,
    this.valueDescription,
    this.term,
    this.teacherName,
    this.teacherLastName,
  });

  final int idUser;
  final String subject;
  dynamic value;
  dynamic valueDescription;
  final dynamic term;
  final String teacherName;
  final String teacherLastName;

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
        subject: json['ds_subject'],
        value: json['mark'],
        valueDescription: json['mark_description'],
        term: json['id_term'],
        teacherName: json['teacher_name'],
        teacherLastName: json['teacher_last_name']);
  }
}
