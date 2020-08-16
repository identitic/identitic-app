import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/models/event.dart';
/* import 'package:identitic/providers/events_provider.dart';
import 'package:provider/provider.dart'; */

import 'package:http/http.dart' as http;
import 'package:identitic/services/storage_service.dart';

import 'package:identitic/utils/constants.dart';
import 'package:identitic/services/exceptions.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage(this.classs);

  final Class classs;

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _category;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Añadir evento en ${widget.classs.year}to ${widget.classs.course}',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addEvent(),
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

  Future<void> _postEvent(Event event, Class classs) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    
    final Map<String, String> jsonHeaders = <String, String>{
      "Content-Type": 'application/json',
      'Authorization': 'Bearer $token'
    };

    Map<String, dynamic> params = {
      "id_class": classs.id, //classs.id
      "id_user": 5,
      "id_subject": event.idSubject,
      "date": event.date,
      "title": event.title,
      "ds_event": event.description,
      "event_category_id_category": event.idCategory
    };
    try {
      final http.Response response = await http.post(
          '${apiBaseUrl}teacher/postevent',
          headers: jsonHeaders,
          body: json.encode(params));
      switch (response.statusCode) {
        case 200:
          {
            debugPrint(response.body);
            break;
          }
        case 401:
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      debugPrint(e.toString());
    }
    Navigator.pop(context);
  }

  void _addEvent() {

    final Event event = Event(
        idClass: widget.classs.id,
        idUser: 5,
        idSubject: 1, //Matemática
        date: _date.toUtc().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        idCategory: _category);

    _postEvent(event, widget.classs);
  }
}
