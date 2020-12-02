import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _checkHierarchy(context),
        label: Row(
          children: <Widget>[
            Icon(Provider.of<AuthProvider>(context, listen: false)
                        .user
                        .hierarchy !=
                    UserHierarchy.teacher
                ? Icons.add
                : Icons.add),
            SizedBox(width: 8),
            Text(Provider.of<AuthProvider>(context, listen: false)
                        .user
                        .hierarchy !=
                    UserHierarchy.teacher
                ? 'Entrega'
                : 'Ver entregas'),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(article.title),
            centerTitle: true,
          ),
          SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  MarkdownBody(data: article?.markdown ?? '"Error"'),
                  article.fileURI != null
                      ? Image.network(apiBaseUrl +
                          "/" +
                          article.fileURI
                              .split('/')
                              .last
                              .replaceFirst(r'\', "/"))
                      : SizedBox()
                ]),
              )),
        ],
      ),
    );
  }

  _checkHierarchy(BuildContext context) {
    // CHECK THE USER HIERARCHY

    Provider.of<AuthProvider>(context, listen: false).user.hierarchy ==
            UserHierarchy.teacher
        ? Navigator.pushNamed(context, RouteName.article_deliveries, arguments: this.article)
        : _checkDeliveryStatus(context);
  }

  _checkDeliveryStatus(BuildContext context) async {
    int idUser = Provider.of<AuthProvider>(context, listen: false).user.id;

    dynamic _articleInfo =
        await Provider.of<ArticlesProvider>(context, listen: false)
            .fetchArticleByID(article.idArticle, idUser);

    _articleInfo.deliveries == 0
        ? Navigator.pushNamed(context, RouteName.new_delivery,
            arguments: article)
        : Navigator.pushNamed(context, RouteName.student_view_delivery,
            arguments: article);
  }
}
