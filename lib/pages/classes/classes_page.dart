import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/classes_provider.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';

enum ClassPageType {
  grades,
  inattendances,
  calendar,
  tasks,
}

class ClassesPage extends StatefulWidget {
  final ClassPageType classPageType;
  String route;
  String title;

  ClassesPage(this.classPageType) {
    switch (classPageType) {
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
          'Mis cursos - ${widget.title}',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Class>>(
        future: Provider.of<ClassesProvider>(context, listen: false)
            .fetchClasses(
                Provider.of<AuthProvider>(context, listen: false).user),
        builder: (_, AsyncSnapshot<List<Class>> snapshot) {
          if (snapshot.hasData) {
            final List<Class> classes = snapshot.data;
            if (classes.length != 0) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, int i) {
                  return SizedBox(height: 8);
                },
                itemCount: classes.length ?? 4,
                itemBuilder: (_, int i) {
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      widget.route,
                      arguments: classes[i],
                    ),
                    title: Text(
                        "${classes[i].year}° ${classes[i].course} - ${classes[i].label}"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  );
                },
              );
            } else {
              return Center(child: Text('No se encontraron cursos disponibles',
                  style: TextStyle(fontSize: 18)));
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
