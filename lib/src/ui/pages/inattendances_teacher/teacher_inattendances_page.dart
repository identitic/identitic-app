import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:identitic/src/models/class.dart';
import 'package:identitic/src/models/inattendance.dart';
import 'package:identitic/src/models/student.dart';
import 'package:identitic/src/providers/inattendances_provider.dart';
import 'package:identitic/src/services/exceptions.dart';
import 'package:identitic/src/ui/pages/inattendances_teacher/widgets/teacher_inattendance_list_tile.dart';
import 'package:identitic/src/utils/constants.dart';

import 'package:provider/provider.dart';

class InattendancesTeacherPage extends StatelessWidget {
  InattendancesTeacherPage(this.classs);

  final Class classs;
  final List<Inattendance> inattendances = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inasistencias', style: TextStyle(fontSize: 16),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Student>>(
        future: _fetchStudents(),
        builder: (_, AsyncSnapshot<List<Student>> snapshot) {
          final List<Student> students = snapshot.data;
          if (snapshot.hasData){
            return ListView.separated(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: students.length,
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, __) {
                return SizedBox(height: 8);
              },
              itemBuilder: (_, int i) {
                return InattendanceTeacherListTile(students[i], inattendances[i]);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => postInattendances(context, inattendances),
        label: Row(
          children: <Widget>[
            Icon(Icons.send),
            SizedBox(width: 8),
            Text('Enviar'),
          ],
        ),
      ),
    );
  }

  Future<List<Student>> _fetchStudents() async {
    List<Student> students;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '${apiBaseUrl}teacher/class/${classs.id}',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            students = list.map((e) {
              final Student student = Student.fromJson(e);
              inattendances.add(Inattendance(idUser: student.idStudent));
              return student;
            } ).toList();
            break;
          }
        case 401:
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e);
    }
    return students;
   
  }


  void postInattendances(BuildContext context, List<Inattendance> _inattendances) async {
    await Provider.of<InattendancesProvider>(context, listen: false)
        .postInattendances(_inattendances);
    Navigator.pop(context);
    
  }
}
