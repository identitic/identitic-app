import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/classes_provider.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/utils/constants.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageCreateState createState() => _SubjectsPageCreateState();
}

class _SubjectsPageCreateState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tareas',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Class>>(
        future: Provider.of<ClassesProvider>(context, listen: false)
            .fetchSubjects(),
        builder: (_, AsyncSnapshot<List<Class>> snapshot) {
          if (snapshot.hasData) {
            final List<Class> subjects = snapshot.data;
            if (subjects.length != 0) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, int i) {
                  return SizedBox(height: 8);
                },
                itemCount: subjects.length ?? 4,
                itemBuilder: (_, int i) {
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteName.tasks_student,
                      arguments: subjects[i],
                    ),
                    title: Text(
                        "${subjects[i].year}° ${subjects[i].course} - ${subjects[i].label}"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  );
                },
              );
            } else {
              return Center(
                  child: Text('No se encontraron materias disponibles',
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
