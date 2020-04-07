import 'package:flutter/material.dart';

class ArticleListItem extends StatelessWidget {
  final String title;
  final String description;

  const ArticleListItem({
    @required this.title,
    @required this.description,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ExpansionTile(
        title: Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 16.0),
        ),
        children: [
          Icon(Icons.launch),
        ],
      ),
    );
  }
}
