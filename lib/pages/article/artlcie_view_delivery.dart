import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: Convertir a teacher/student, usar future builder

class ViewDeliveryPage extends StatefulWidget {
  const ViewDeliveryPage([this.delivery]);

  final dynamic delivery;

  @override
  _ViewDeliveryPageState createState() => _ViewDeliveryPageState();
}

class _ViewDeliveryPageState extends State<ViewDeliveryPage> {
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
            '${widget.delivery.userLastName + ' ' + widget?.delivery?.userName}',
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
                [_buildStudentDelivery(), _deliveryStatus()],
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
                  widget.delivery.deliveries[0]['body'] ?? 'Entregó sin cuerpo',
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
                  widget.delivery.deliveries[0]['body'] ?? 'Entregó sin cuerpo',
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

  Future<void> _launchFileOnWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _correctDelivery() async {
    Navigator.pushNamed(context, RouteName.correct_delivery,
        arguments: widget.delivery);
  }

  _deliveryStatus() {
    switch (Provider.of<AuthProvider>(context, listen: false).user.hierarchy) {
      case UserHierarchy.student:
        return null;
      case UserHierarchy.teacher:
        return null;
    }
  }

  _checkHierarchy(BuildContext context) {
    // CHECK THE USER HIERARCHY
    switch (Provider.of<AuthProvider>(context, listen: false).user.hierarchy) {
      case UserHierarchy.teacher:     // IF IS TEACHER, IT WILL SHOW A FLOATINGACTIONBUTTON
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
        return null;              // IF IS STUDENT, IT WILL NOT SHOW A FLOATINGACTIONBUTTON
    }
  }
}
