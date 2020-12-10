import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identitic/models/grade.dart';
import 'package:identitic/models/student.dart';

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
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
      title: Text('${widget.student.lastName}'),
      subtitle: Text('${widget.student.name}'),
      trailing: SizedBox(
        width: 64,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) => widget.grade.value = int.tryParse(value),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[A-Z 0-9]')),
            FilteringTextInputFormatter.deny(RegExp('[a-z] ' ' á-ú Á-Ú')),
            LengthLimitingTextInputFormatter(2),
          ],
        ),
      ),
    );
  }
}
