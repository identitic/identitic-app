import 'package:flutter/material.dart';
import 'package:identitic/models/inattendance.dart';

import 'package:identitic/models/student.dart';

class InattendanceTeacherListTile extends StatefulWidget {
  const InattendanceTeacherListTile([this.student, this.inattendance]);

  final Student student;
  final Inattendance inattendance;
  @override
  _InattendanceTeacherListTileState createState() =>
      _InattendanceTeacherListTileState();
}

class _InattendanceTeacherListTileState
    extends State<InattendanceTeacherListTile> {
  int _currentInattendance = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
      title: Text('${widget.student.lastName}'),
      subtitle: Text('${widget.student.name}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Radio(
            groupValue: true,
            value: _currentInattendance == 0,
            onChanged: (newValue) => _setInattendance(0),
            activeColor: Colors.green,
          ),
          Radio(
            groupValue: true,
            value: _currentInattendance == 1,
            onChanged: (newValue) => _setInattendance(1),
            activeColor: Colors.yellow,
          ),
          Radio(
            groupValue: true,
            value: _currentInattendance == 2,
            onChanged: (newValue) => _setInattendance(2),
            activeColor: Colors.red,
          ),
        ],
      ),
    );
  }

  void _setInattendance(int newValue) {
    setState(() {
      _currentInattendance = newValue;
    });
    switch (newValue) {
      case 2:
        widget.inattendance.value = 1;
        break;
      case 1:
        widget.inattendance.value = 0.5;
        break;
      case 0:
        widget.inattendance.value = 0;
        break;
      default:
        widget.inattendance.value = 0;
        break;
    }
  }
}
