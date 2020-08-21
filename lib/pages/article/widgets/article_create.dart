import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/article.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ArticleCreatePage extends StatefulWidget {
  const ArticleCreatePage(this.classs);

  final Class classs;

  @override
  _ArticleCreatePageState createState() => _ArticleCreatePageState();
}

class _ArticleCreatePageState extends State<ArticleCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  /* int _category; */
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear artículo',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
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
          TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
              //hintText: 'Cuerpo',
            ),
            controller: _bodyController,
          ),
          SizedBox(height: 16),
          /* ListTile(
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
          ), */
          ListTile(
            title: Text('Fecha de entrega'),
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

  void _postArticle(BuildContext context) async {
    Article article = Article(
        idJoin: widget.classs.idJoin,
        title: _titleController.text,
        body: _bodyController.text,
        date: DateTime.now().toUtc().toString(),
        deadline: _date?.toUtc().toString()?? 'null',
        idHierarchy: 2);

    Provider.of<ArticlesProvider>(context, listen: false).postArticle(
        Provider.of<AuthProvider>(context, listen: false).user, article);

    Navigator.pop(context);
  }
}
