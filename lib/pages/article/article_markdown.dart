import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:identitic/models/article.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:provider/provider.dart';


//TODO: Convertir "Cuerpo" en una pantalla aparte que sea EditorPage con un boton para "Confirmar"

class EditorPage extends StatefulWidget {
  const EditorPage([this.classs]);
  final Class classs;
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _titleController = TextEditingController();

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
        title: Text('Título de la publicación'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _postArticle(context),
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
            title: Text('Cuerpo'),
          ),
          showEditor
              ? TextField(
                  controller: _textEditingController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Cuerpo',
                  ),
                  onTap: () {
                    setState(() => {this._tappedCount++});
                  },
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                )
              : SizedBox.expand(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() => {this._tappedCount++});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MarkdownBody(data: this._text),
                    ),
                  ),
                ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Fecha de entrega'),
            trailing: FlatButton(
              child: _date != null
                  ? Text(_date.day.toString() +
                      '/' +
                      _date.month.toString() +
                      '/' +
                      _date.year.toString(), style: TextStyle(color: Colors.blue),)
                  : Text('Seleccionar fecha', style: TextStyle(color: Colors.blue),),
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
          ),
/*         ],
      ), */
        ],
      ),
    );
  }

  void _postArticle(BuildContext context) async {
    Article article = Article(
        /* idJoin: widget.classs.idJoin,
          title: _titleController.text,
          body: _bodyController.text,
          date: DateTime.now().toUtc().toString(),
          deadline: _date?.toUtc().toString() ?? 'null',
          idHierarchy: 2 */
        );

    Provider.of<ArticlesProvider>(context, listen: false).postArticle(
        Provider.of<AuthProvider>(context, listen: false).user, article);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
