import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/classes_provider.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/models/event.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/events_provider.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage([this.classs, this.previousDate]);

  final Class classs;
  final DateTime previousDate;

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _category;
  DateTime _date;
  int _idJoinSelectedClass;
  List<Class> _classes;

  @override
  void initState() {
    super.initState();
    _date = widget.previousDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: true,
            title: widget.classs == null
                ? Text('Añadir evento')
                : Text(
                    'Añadir evento - ${widget.classs.year}to ${widget.classs.course}',
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
        body: FutureBuilder(
            future: Provider.of<ClassesProvider>(context, listen: false)
                .fetchClasses(
                    Provider.of<AuthProvider>(context, listen: false).user),
            builder: (_, AsyncSnapshot snapshot) {
              List<Class> classes = snapshot.data;
              if (snapshot.hasData) {
                if (classes.length != 0) {
                  List<DropdownMenuItem<int>> _dropdownMenuItems;
                  List<DropdownMenuItem<int>> _buildDropdownMenuItems(
                      List<Class> classes) {
                    List<DropdownMenuItem<int>> items = List();
                    for (Class classs in classes) {
                      items.add(DropdownMenuItem(
                        value: classs.idJoin,
                        child: Text(classs.year.toString() +
                            '°' +
                            classs.course +
                            ' ' +
                            classs.label),
                      ));
                    }
                    return items;
                  }

                  _dropdownMenuItems = _buildDropdownMenuItems(classes);
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      ListTile(
                        title: Text('Curso'),
                        trailing: DropdownButton(
                          hint: Text('Seleccionar curso'),
                          value: _idJoinSelectedClass,
                          items: _dropdownMenuItems,
                          onChanged: (newValue) {
                            setState(() {
                              _idJoinSelectedClass = newValue;
                              _classes = classes;
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
                          enabledBorder: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
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
                          enabledBorder: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
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
                              value: 8,
                            ),
                            DropdownMenuItem(
                              child: Text('Entregas'),
                              value: 7,
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
                          child: _date != null
                              ? Text(
                                  _date.day.toString() +
                                      '/' +
                                      _date.month.toString() +
                                      '/' +
                                      _date.year.toString(),
                                  style: TextStyle(color: Colors.blue),
                                )
                              : Text(
                                  'Seleccionar fecha',
                                  style: TextStyle(color: Colors.blue),
                                ),
                          onPressed: () async {
                            _date = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.now().add(Duration(seconds: 10)),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 610)));
                            setState(() {
                              _date = _date;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                    child: Text(
                  'No se encontraron cursos disponibles',
                  style: TextStyle(fontSize: 18),
                ));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }


  Future<void> _postEvent() async {
    Class _selectedClass = _classes
        .where((element) => element.idJoin == _idJoinSelectedClass)
        .toList()[0];

    final Event event = Event(
        idClass: _selectedClass.id,
        idJoin: _selectedClass.idJoin,
        date: _date.toUtc().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        idCategory: _category);

    await Provider.of<EventsProvider>(context, listen: false).postEvent(event);

    Navigator.pop(context);
  }
}
