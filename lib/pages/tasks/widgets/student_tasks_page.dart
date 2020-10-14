import 'package:flutter/material.dart';
import 'package:identitic/models/articles/article.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/pages/article/widgets/article_list_tile.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class StudentTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Tareas',
          ),
          centerTitle: true),
      body: FutureBuilder<List<Article>>(
        future: Provider.of<ArticlesProvider>(context, listen: false)
            .fetchFamiliesArticles(
                Provider.of<AuthProvider>(context, listen: false).user.idClass,
                Provider.of<AuthProvider>(context, listen: false).user.id),
        builder: (_, AsyncSnapshot<List<Article>> snapshot) {
          final List<Article> _articles = snapshot.data;
          if (snapshot.hasData) {
            if (_articles.length != 0) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, int i) {
                  return SizedBox(height: 8);
                },
                itemCount: _articles.length ?? 5,
                itemBuilder: (_, int i) {
                  return ArticleListTile(_articles[i]);
                },
              );
            } else {
              return Center(
                child: Text(
                  'No hay nuevas noticias!',
                  style: TextStyle(fontSize: 16),
                ),
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
