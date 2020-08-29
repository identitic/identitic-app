import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:identitic/models/article.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/utils/constants.dart';

class ArticleCreatePage extends StatefulWidget {
  const ArticleCreatePage([this.classs]);
  final Class classs;
  @override
  _ArticleCreatePageState createState() => _ArticleCreatePageState();
}

class _ArticleCreatePageState extends State<ArticleCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final picker = ImagePicker();

  File imageFile;

  TextEditingController _textEditingController;
  DateTime _date;
  int _tappedCount = 1;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    var showEditor = !(_tappedCount % 3 == 0);
    if (!showEditor) {
      _textEditingController.text = _text;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear artículo'),
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _generateArticle(),
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Crear'),
          ],
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Título',
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    maxLines: null,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            controller: _titleController,
          ),
          Divider(),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cuerpo',
                hintStyle: TextStyle(fontWeight: FontWeight.w600)),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _bodyController,
          ),
          SizedBox(height: 16),
          FlatButton(
            color: imageFile == null ? Colors.blue : null,
            child: imageFile == null
                ? Text(
                    'Adjuntar multimedia',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                : Container(
                    child: Image.file(imageFile),
                    height: 282,
                    width: 282,
                  ),
            onPressed: () {
              _selectImageGallery(context);
            },
          )
        ],
      ),
    );
  }

  Future _selectImageGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  Future<void> _generateArticle() async {
    
    Article _article = Article(
        idJoin: widget.classs.idJoin,
        title: _titleController?.text?? 'Salio mal xdd',
        body: _bodyController?.text?? 'Salio mal xd',
        image: imageFile != null ? FileImage(imageFile) : null,
        date: DateTime.now().toUtc().toString(),
        deadline: _date?.toUtc()?.toString() ?? null,
        idHierarchy: 2);

    Navigator.pushNamed(context, RouteName.article_markdown,
        arguments: _article);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
