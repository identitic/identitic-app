import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';

//TODO: Checkear esta pagina

class TeacherViewDeliveryPage extends StatefulWidget {
  const TeacherViewDeliveryPage([this.delivery]);

  final dynamic delivery;

  @override
  _TeacherViewDeliveryPageState createState() =>
      _TeacherViewDeliveryPageState();
}

class _TeacherViewDeliveryPageState extends State<TeacherViewDeliveryPage> {
  UserHierarchy hierarchy;

  bool enableNewDeliveries;
  File selectedFile;
  PlatformFile previewFile;
  List<File> files;

  @override
  void initState() {
    enableNewDeliveries = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget?.delivery?.userLastName ?? 'xd' + ' ' + widget?.delivery?.userName ?? 'xd'}',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
        ),
        floatingActionButton: _checkHierarchy(context),
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  _buildStudentDelivery(),
                  hierarchy == UserHierarchy.student
                      ? _deliveryCorrection()
                      : null
                ],
              )),
            ]));
  }

  Widget _buildStudentDelivery() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: <Widget>[
          ListTile(
            title: Text('Cuerpo'),
          ),
          // VIEW DELIVERY BODY
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText:
                  widget.delivery.deliveries[0]['body'] ?? 'Entrega sin cuerpo',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Observaciones del alumno/a'),
          ),
          // VIEW DELIVERY OBSERVATIONS FOR TEACHER
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText:
                  widget.delivery.deliveries[0]['body'] ?? 'Entrega sin cuerpo',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 32),
          FlatButton(
            color: Colors.blue,
            onPressed: () =>
                _launchFileOnWeb(widget?.delivery?.deliveries[0]['file']),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ver archivo adjunto',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ]));
  }

  _deliveryCorrection() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: <Widget>[
          //TODO: Checkear si HAY CORRECTION del docente
          ListTile(
            title: Text('Devolución del docente'),
          ),
          // VIEW DELIVERY BODY
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: widget.delivery.body ?? 'Devolución sin cuerpo',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          )
        ]));
  }

  _checkHierarchy(BuildContext context) {
    // CHECK THE USER HIERARCHY
    switch (Provider.of<AuthProvider>(context, listen: false).user.hierarchy) {
      case UserHierarchy.teacher:
        setState(() {
          hierarchy = UserHierarchy.teacher;
        }); // IF IS TEACHER, IT WILL SHOW A FLOATINGACTIONBUTTON
        return FloatingActionButton.extended(
          onPressed: () => _correctDelivery(),
          label: Row(
            children: <Widget>[
              Icon(Icons.done),
              SizedBox(width: 8),
              Text('Corregir'),
            ],
          ),
        );

      case UserHierarchy.student:
        return null; // IF IS STUDENT, IT WILL NOT SHOW A FLOATINGACTIONBUTTON
    }
  }

  Future<void> _launchFileOnWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _correctDelivery() async {
    Navigator.pushNamed(context, RouteName.correct_delivery,
        arguments: widget.delivery);
  }
}
