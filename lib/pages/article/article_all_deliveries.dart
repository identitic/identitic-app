//TODO: pagina que traiga una lista de estudiantes y si subieron o no una respuesta

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/articles/article.dart';
import 'package:identitic/pages/article/widgets/deliveries_list_tile.dart';

class ArticleAllDeliveries extends StatefulWidget {
  const ArticleAllDeliveries(this.article);

  final Article article;

  @override
  _ArticleAllDeliveriesCreateState createState() => _ArticleAllDeliveriesCreateState();
}

class _ArticleAllDeliveriesCreateState extends State<ArticleAllDeliveries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Entregas - ${widget.article.title}',
          ),
          centerTitle: true),
      body: FutureBuilder<List<Article>>(
/*         future: Provider.of<ArticlesProvider>(context, listen: false)
            .fetchArticles(widget.classs.id), */
        builder: (_, AsyncSnapshot<List<Article>> snapshot) {
          final List<Article> students = snapshot.data;
          if (snapshot.hasData) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, int i) {
                return SizedBox(height: 8);
              },
              itemCount: students.length ?? 5,
              itemBuilder: (_, int i) {
                return DeliveryListTile(students[i]);
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