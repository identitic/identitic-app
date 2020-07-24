import 'package:flutter/material.dart';
import 'package:identitic/models/article.dart';
import 'package:identitic/utils/constants.dart';

class ArticleListTile extends StatelessWidget {
  const ArticleListTile(this._article);

  final Article _article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        RouteName.article,
        arguments: _article,
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
      title: Text(_article.title),
      subtitle: Text(
        _article.body,
        maxLines: 1,
      ),
      trailing: Text(
        '${_article.date[8]}' +
            '${_article.date[9]}' +
            '/' +
            '${_article.date[5]}' +
            '${_article.date[6]}',
        style: TextStyle(color: Theme.of(context).textTheme.caption.color),
      ),
    );
  }
}
