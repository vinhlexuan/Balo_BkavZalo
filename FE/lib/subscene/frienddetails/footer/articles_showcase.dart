import 'package:flutter/material.dart';

class ArticlesShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
        'Danh sách bạn đã bị ẩn.',
        style: textTheme.headline6!.copyWith(color: Colors.white),
      ),
    );
  }
}