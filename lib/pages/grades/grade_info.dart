import 'package:flutter/material.dart';
import 'package:identitic/models/grade.dart';

class GradeInfo extends StatelessWidget {
  const GradeInfo(this.grade);

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(grade?.subject ?? 'Calificación'),
            centerTitle: true,
          ),
          SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontSize: 18),
                        children: [
                          TextSpan(
                              text: 'Calificación: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${grade?.value != null ? '${grade.value.toString()} \n\n' : 'No hay una calificación disponible \n\n'}',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(
                              text: 'Descripción: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${grade?.valueDescription != null ? '${grade.valueDescription} \n\n' : 'No hay una descripción disponible \n\n'}'),
                          TextSpan(
                              text:
                                  '${grade?.teacherName != null ? 'Profesor/a: ' : ''}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${grade?.teacherName != null ? '${grade.teacherName + ' ' + grade.teacherLastName}' : ''}'),
                        ]),
                  ),
                ]),
              )),
        ],
      ),
    );
  }
}
