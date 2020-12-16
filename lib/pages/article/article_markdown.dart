import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:identitic/models/articles/article.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  const EditorPage(this.article);

  final Article article;

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  TextEditingController _textEditingController;
  bool enableComments = false;
  bool enableDeliveries = false;
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
          title: Text(
            'Crear artículo',
            style: TextStyle(fontSize: 16),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _postArticle(context);
          },
          label: Row(
            children: <Widget>[
              Icon(Icons.done),
              SizedBox(width: 8),
              Text('Confirmar'),
            ],
          ),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
                [buildArticlePreview(), buildArticleSettings()]),
          )
        ]));
  }

  Widget buildArticlePreview() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget?.article?.markdown != null
              ? MarkdownBody(data: widget.article.markdown)
              : SizedBox(),
          widget?.article?.image != null
              ? Image.file(widget.article.image)
              : SizedBox(),
        ],
      ),
    );
  }

  // Enable comments, deliveries, deadlines, etc
  Widget buildArticleSettings() {
    return Column(children: <Widget>[
      Divider(),
      SwitchListTile.adaptive(
        title: Text(
          'Habilitar comentarios'),
        activeColor: Colors.blue,
          value: enableComments,
          onChanged: (bool state) {
            setState(() {
              enableComments = state;
            });
          }
      ),
       SwitchListTile.adaptive(
        title: Text(
          'Habilitar entregas'),
        activeColor: Colors.blue,
          value: enableDeliveries,
          onChanged: (bool state) {
            setState(() {
              enableDeliveries = state;
            });
          }
      ),
      enableDeliveries != false
          ? ListTile(
              title: Text('Fecha límite'),
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
                      initialDate: DateTime.now().add(Duration(seconds: 10)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 610)));
                  setState(() {
                    _date = _date;
                  });
                },
              ),
            )
          : SizedBox(),
      SizedBox(height: 32),
    ]);
  }

  void _postArticle(BuildContext context) async {
    Provider.of<ArticlesProvider>(context, listen: false).postArticle(
        Provider.of<AuthProvider>(context, listen: false).user, widget.article);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
