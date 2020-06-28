import 'package:flutter/material.dart';
import 'package:identitic/src/models/article.dart';
import 'package:identitic/src/models/class.dart';
import 'package:identitic/src/providers/articles_provider.dart';
import 'package:identitic/src/ui/pages/article/widgets/article_list_tile.dart';
import 'package:identitic/src/utils/constants.dart';
import 'package:provider/provider.dart';

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
        title: Text('Tareas - ${widget.classs.label}', style: TextStyle(fontSize: 16),), 
        centerTitle: true
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, RouteName.article_create),
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
            .fetchArticles(), //fetchArticlesByCLass(classs)
        builder: (_, AsyncSnapshot<List<Article>> snapshot) {
          final List<Article> articles = snapshot.data;
          if (snapshot.hasData) {
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
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
