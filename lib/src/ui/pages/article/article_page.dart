import 'package:flutter/material.dart';
import 'package:identitic/src/models/article.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage(this._article);

  final Article _article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Identitic'),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                /* Image(
                  image: _article.image,
                ), */
                const SizedBox(height: 16),
                Text(
                  _article.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 16),
                
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(),
                Text(_article.body)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
