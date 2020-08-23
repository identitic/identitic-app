import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/user.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/class.dart';
import 'package:identitic/models/event.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/events_provider.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage([this.classs]);

  final Class classs;

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _category;
  DateTime _date;
  int _idJoinSelectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: widget.classs == null
              ? Text('Añadir evento')
              : Text(
                  'Añadir evento - ${widget.classs.year}to ${widget.classs.course}',
                  style: TextStyle(fontSize: 18),
                )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _postEvent(),
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Añadir'),
          ],
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: <Widget>[
          ListTile(
            title: Text('Curso'),
            trailing: DropdownButton(
              hint: Text('Seleccionar curso'),
              value: _idJoinSelectedClass, 
              items: [
                DropdownMenuItem(
                  child: Text('1ero A'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('5to A'),
                  value: 2,
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _idJoinSelectedClass = newValue;
                });
              }, 
            ),
          ),
          ListTile(
            title: Text('Título'),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Título',
            ),
            controller: _titleController,
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Descripción'),
          ),
          TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Descripción',
            ),
            controller: _descriptionController,
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Categoría'),
            trailing: DropdownButton(
              hint: Text('Seleccionar categoría'),
              value: _category,
              items: [
                DropdownMenuItem(
                  child: Text('Exámenes'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('Entregas'),
                  value: 2,
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _category = newValue;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Fecha'),
            trailing: FlatButton(
              child: Text('Seleccionar fecha'),
              onPressed: () async {
                _date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(seconds: 10)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 610)));
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _postEvent() async {
    User _user = Provider.of<AuthProvider>(context, listen: false).user;

    final Event event = Event(
        idClass: widget.classs.id,
        idUser: _user.id,
        idSubject: widget.classs.idSubject,
        date: _date.toUtc().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        idCategory: _category);

    await Provider.of<EventsProvider>(context, listen: false)
        .postEvent(_user, event, widget.classs);

    Navigator.pop(context);
  }
}
