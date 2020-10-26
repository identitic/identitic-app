import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:provider/provider.dart';

class CorrectDeliveryPage extends StatefulWidget {
  const CorrectDeliveryPage(this.delivery);

  final dynamic delivery;

  @override
  _CorrectDeliveryPageState createState() => _CorrectDeliveryPageState();
}

class _CorrectDeliveryPageState extends State<CorrectDeliveryPage> {
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _markController = TextEditingController();

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
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _uploadReturn(),
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
                [buildTeacherReturn()],
              )),
            ]));
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
              title: Text('Nota'),
            ),
            TextField(
              maxLines: 1,
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
              controller: _markController,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Text(
                'Debe reentregar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: enableNewDeliveries,
                onChanged: (bool state) {
                  setState(() {
                    enableNewDeliveries = state;
                  });
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
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
          ],
        ));
  }

  Future<void> _pickFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path)).toList();

        previewFile = result.files.first;
      });
    }
  }

  Future<void> _uploadReturn() async {
    var _return = {
      'mark': _markController.text ?? null,
      'id_delivery': widget?.delivery?.deliveries[0]['id_delivery'] ?? null,
      'body': _bodyController.text ?? null,
      'filee': selectedFile ?? null,
      'date': DateTime.now().toIso8601String().toString(),
    };

    await Provider.of<ArticlesProvider>(context, listen: false)
        .uploadReturn(_return);
  }
}
