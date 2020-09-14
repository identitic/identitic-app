import 'package:flutter/material.dart';
import 'package:identitic/models/article.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/pages/article/widgets/article_list_tile.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';

class FamiliesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Familias',
          ),
          centerTitle: true),
          floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
            context,
            RouteName
                .article_create),
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Crear artículo'),
          ],
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future: Provider.of<ArticlesProvider>(context, listen: false)
            .fetchFamiliesArticles(
                Provider.of<AuthProvider>(context, listen: false)
                    .user
                    .idSchool),
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
                child: Text('No hay artículos nuevos :(', style: TextStyle(fontSize: 16),),
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
