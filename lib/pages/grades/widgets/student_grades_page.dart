import 'package:flutter/material.dart';

import 'package:identitic/pages/grades/widgets/student_grades_list_view.dart';

class StudentGradesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calificaciones',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: StudentGradesListView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: <Widget>[
            Icon(
              Icons.history,
              color: Colors.white,
            ),
            SizedBox(
              width: 16,
            ),
            Text('Ver por trimestres'),
          ],
        ),
      ),
    );
  }
}
