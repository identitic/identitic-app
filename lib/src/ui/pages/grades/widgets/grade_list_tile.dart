import 'package:flutter/material.dart';
import 'package:identitic/src/models/grade.dart';
import 'package:identitic/src/models/student.dart';
import 'package:identitic/src/ui/widgets/identitic_container.dart';

class GradeListTile extends StatefulWidget {
  const GradeListTile(this.student, this.grade);

  final Student student;
  final Grade grade;

  @override
  _GradeListTileState createState() => _GradeListTileState();
}

class _GradeListTileState extends State<GradeListTile> {
  @override
  Widget build(BuildContext context) {
    return IdentiticContainer(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        title: Text('${widget.student.lastName}'),
        subtitle: Text('${widget.student.name}'),
        trailing: SizedBox(
          width: 32,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => widget.grade.value = int.tryParse(value), //Cambiar a double? Hablar con back
          ),
        ),
      ),
    );
  }
}

