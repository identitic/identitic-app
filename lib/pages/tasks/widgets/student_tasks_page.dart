import 'package:flutter/material.dart';
import 'package:identitic/models/article.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/pages/article/widgets/article_list_tile.dart';
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
            .fetchFamiliesArticles(),
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
