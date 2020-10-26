import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage([this.article]);

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
                : SizedBox()),
            SizedBox(width: 8),
            Text(Provider.of<AuthProvider>(context, listen: false)
                        .user
                        .hierarchy !=
                    UserHierarchy.teacher
                ? 'Subir entrega'
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
                  MarkdownBody(data: article.markdown),
                  article.fileURI != null
                      ? Image.network('https://' + article.fileURI)
                      : null
                ]),
              )),
        ],
      ),
    );
  }

  _checkHierarchy(BuildContext context) {
 Provider.of<AuthProvider>(context, listen: false).user.hierarchy !=
                    UserHierarchy.teacher
                ? Navigator.pushNamed(context, RouteName.new_delivery,
                    arguments: article)
                : Navigator.pushNamed(context, RouteName.view_delivery,
                    arguments: article);
  }
}
