import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:identitic/models/article.dart';
import 'package:identitic/utils/constants.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage([this.article]);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          /* Provider.of(context)<AuthProvider>().user.hierarchy ==
                  UserHierarchy.student
              ? */
          FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, RouteName.new_delivery),
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Subir entrega'),
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
}
