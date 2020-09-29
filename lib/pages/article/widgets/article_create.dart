import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear artículo'),
        actions: [
          IconButton(
            icon: Icon(OMIcons.addAPhoto),
            color: Colors.blue,
            iconSize: 26,
            onPressed: () => _selectImageGallery(context),
          ),
        ],
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
              hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            textAlign: TextAlign.justify,
            textAlignVertical: TextAlignVertical.bottom,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _bodyController,
          ),
          imageFile != null
              ? Container(
                  child: Image.file(imageFile),
                  height: 282,
                  width: 282,
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(top: 32),
                )
              : SizedBox()
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
    String _markdown = """# __${_titleController.text}__
### ${_bodyController.text}
""";

    Article _article = Article(
        markdown: _markdown != null ? _markdown : null,
        image: imageFile != null ? imageFile : null,
        idJoin: widget?.classs != null ? widget.classs.idJoin : 93, //TODO: cambiar lo del id join, en el back permitan todo
        date: DateTime.now().toUtc().toString(),
        idHierarchy: widget?.classs != null ? 2 : 1,
        title: _titleController.text ?? _titleController.text,
        body: _bodyController.text ?? _bodyController.text);

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
