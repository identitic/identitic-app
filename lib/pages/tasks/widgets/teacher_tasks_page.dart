import 'package:flutter/material.dart';
import 'package:identitic/providers/auth_provider.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/pages/article/widgets/article_list_tile.dart';
import 'package:identitic/utils/constants.dart';

class TeacherTasksPage extends StatefulWidget {
  const TeacherTasksPage(this.classs);

  final Class classs;

  @override
  _TasksPageCreateState createState() => _TasksPageCreateState();
}

class _TasksPageCreateState extends State<TeacherTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Tareas - ${widget.classs.label}',
          ),
          centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, RouteName.article_create,
            arguments: widget.classs),
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Crear tarea'),
          ],
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future: Provider.of<ArticlesProvider>(context, listen: false)
            .fetchArticlesBySubject(widget.classs.idJoin,
                Provider.of<AuthProvider>(context, listen: false).user.id),
        builder: (_, AsyncSnapshot<List<Article>> snapshot) {
          final List<Article> articles = snapshot.data;
          if (snapshot.hasData) {
            if (articles.length != 0) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, int i) {
                  return SizedBox(height: 8);
                },
                itemCount: articles.length ?? 5,
                itemBuilder: (_, int i) {
                  return ArticleListTile(articles[i]);
                },
              );
            } else {
              return Center(
                child: Text('No hay artículos disponibles',
                    style: TextStyle(fontSize: 18)),
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
