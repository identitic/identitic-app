class Inattendance {
  Inattendance({
    this.idUser,
    this.date,
    this.value,
  });

  final int idUser;
  final String date; //DateTime
  dynamic value; //Double

  factory Inattendance.fromJson(Map<String, dynamic> json) {
    return Inattendance(
      date: json['date'], //Parse
      value: json['status'], 
    );
  }
}
