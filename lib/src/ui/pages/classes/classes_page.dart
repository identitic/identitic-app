import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:identitic/src/models/class.dart';
import 'package:identitic/src/models/user.dart';
import 'package:identitic/src/providers/auth_provider.dart';

import 'package:identitic/src/ui/widgets/identitic_container.dart';
import 'package:identitic/src/utils/constants.dart';
import 'package:identitic/src/services/exceptions.dart';


enum ClassPageType {
  grades,
  inattendances,
  calendar,
  tasks
}

class ClassesPage extends StatefulWidget {
  final ClassPageType classPageType;
  String route;
  String title;

  ClassesPage(this.classPageType){
    switch(classPageType){
      case ClassPageType.grades:
        route = RouteName.grades_teacher;
        title = "Calificaciones";
        break;
      case ClassPageType.inattendances:
        route = RouteName.inattendances_teacher;
        title = "Inasistencias";
        break;
      case ClassPageType.calendar:
        route = RouteName.class_calendar;
        title = "Calendario";
        break;
      case ClassPageType.tasks:
        route = RouteName.tasks_teacher;
        title = "Tareas";
        break;
    }
  }

  @override
  _ClassesPageCreateState createState() => _ClassesPageCreateState();
}

class _ClassesPageCreateState extends State<ClassesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Mis cursos - ${widget.title}', style: TextStyle(fontSize: 16),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Class>>(
        future: _fetchClasses(Provider.of<AuthProvider>(context,listen:false).user),
        builder: (_, AsyncSnapshot<List<Class>> snapshot) {
          final List<Class> classes = snapshot.data;
          if (snapshot.hasData) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, int i) {
                return SizedBox(height: 8);
              },
              itemCount: classes.length ?? 4,
              itemBuilder: (_, int i) {
                return IdentiticContainer(
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      widget.route,
                      arguments: classes[i],
                    ),
                    title: Text("${classes[i].year}° ${classes[i].course} - ${classes[i].label}"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<Class>> _fetchClasses(User user) async {
    List<Class> classes;

    Map<String, dynamic> params = {'id_user': user.id, 'id_school': user.idSchool};

    try {
      final http.Response response = await http.post(
          '${apiBaseUrl}teacher/classes',
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(params));
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            classes = list.map((e) => Class.fromJson(e)).toList();
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
    return classes;
  }
}
