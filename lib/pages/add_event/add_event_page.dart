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
  List<Class> _classes;

  @override
  void initState() {
    super.initState();
  }

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
        body: FutureBuilder(
            future: Provider.of<ClassesProvider>(context, listen: false)
                .fetchClasses(
                    Provider.of<AuthProvider>(context, listen: false).user),
            builder: (_, AsyncSnapshot snapshot) {
              List<Class> classes = snapshot.data;
              if (snapshot.hasData) {
                if (classes.isNotEmpty && classes != null) {
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
                                initialDate:
                                    DateTime.now().add(Duration(seconds: 10)),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 610)));
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Future<void> _postEvent() async {
    Class _selectedClass = _classes
            .where((element) => element.idJoin == _idJoinSelectedClass)
            .toList()[0];

    print(_selectedClass.id);
    final Event event = Event(
        idClass: _selectedClass.id,
        idJoin: _selectedClass.idJoin,
        date: _date.toUtc().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        idCategory: _category);

    await Provider.of<EventsProvider>(context, listen: false)
        .postEvent(event);

    Navigator.pop(context);
  }
}
