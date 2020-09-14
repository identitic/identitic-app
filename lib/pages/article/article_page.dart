import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:identitic/models/article.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage([this.article]);

  final Article article;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Image.network('https://' + article.fileURI)
            ]),
          )
          ),
        ],
      ),
    );
  }
}
