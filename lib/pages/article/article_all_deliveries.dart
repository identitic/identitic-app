//TODO: pagina que traiga una lista de estudiantes y si subieron o no una respuesta

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/articles/delivery.dart';
import 'package:identitic/pages/article/widgets/deliveries_list_tile.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:provider/provider.dart';

class ArticleAllDeliveries extends StatefulWidget {
  const ArticleAllDeliveries(this.article);

  final Article article;

  @override
  _ArticleAllDeliveriesCreateState createState() =>
      _ArticleAllDeliveriesCreateState();
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
      body: FutureBuilder(
        future: Provider.of<ArticlesProvider>(context, listen: false)
            .fetchDeliveriesByPost(widget.article),
        builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
          final List<Delivery> deliveries = snapshot.data;
          if (snapshot.hasData) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, int i) {
                return SizedBox(height: 8);
              },
              itemCount: deliveries.length ?? 5,
              itemBuilder: (_, int i) {
                return DeliveryListTile(deliveries[i]);
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
