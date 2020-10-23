import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:identitic/models/articles/delivery.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ViewDeliveryPage extends StatefulWidget {
  const ViewDeliveryPage([this.delivery]);

  final dynamic delivery;

  @override
  _ViewDeliveryPageState createState() => _ViewDeliveryPageState();
}

class _ViewDeliveryPageState extends State<ViewDeliveryPage> {
  final TextEditingController _bodyController = TextEditingController();
  bool enableGroup;

  File selectedFile;
  PlatformFile previewFile;

  List<File> files;

  @override
  void initState() {
    enableGroup = false;
    super.initState();
  }

//TODO: ESTO XD
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
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _uploadDelivery(),
          label: Row(
            children: <Widget>[
              Icon(Icons.done),
              SizedBox(width: 8),
              Text('Confirmar'),
            ],
          ),
        ),
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(
                [buildStudentDelivery(), 
                buildTeacherReturn()],
              )),
            ]));
  }

  Widget buildStudentDelivery() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            widget?.delivery?.body != null
              ? MarkdownBody(data: widget.delivery.body)
              : Text('hola'),
          widget?.delivery?.file != null
              ? Image.file(widget.delivery.file)
              : SizedBox(),
          ]
        )
    );
  }

  Widget buildTeacherReturn() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Correción'),
            ),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.text,
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
              controller: _bodyController,
            ),
            SizedBox(height: 32),
            FlatButton(
              color: Colors.blue,
              onPressed: () => _pickFile(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Adjuntar archivo',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            previewFile != null
                ? ListTile(
                    leading: Text(
                      'Archivo seleccionado',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                        '${previewFile.name[0] + previewFile.name[1] + previewFile.name[2] + '..' + previewFile.name[previewFile.name.length - 4] + previewFile.name[previewFile.name.length - 3] + previewFile.name[previewFile.name.length - 2] + previewFile.name[previewFile.name.length - 1]}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  )
                : SizedBox(),
            ListTile(
              leading: Text(
                'Permitir reentrega',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: enableGroup,
                onChanged: (bool state) {
                  setState(() {
                    enableGroup = state;
                  });
                },
              ),
            ),
            enableGroup == true
                ? ListTile(
                    title: Text('Integrantes'),
                  )
                : SizedBox(),
            enableGroup == true
                ? TextField(
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
                    controller: _bodyController,
                  )
                : SizedBox()
          ],
        ));
  }

  _pickFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path)).toList();

        previewFile = result.files.first;
      });
    }
  }

  _uploadDelivery() async {
    Delivery _delivery = Delivery(
      idUser: Provider.of<AuthProvider>(context, listen: false).user.id,
      idArticle: widget?.delivery?.idArticle ?? null,
      body: _bodyController.text ?? null,
      file: selectedFile ?? selectedFile,
      date: DateTime.now().toUtc().toString(),
    );

    await Provider.of<ArticlesProvider>(context, listen: false)
        .uploadDelivery(_delivery);

    Navigator.pop(context);
  }
}
