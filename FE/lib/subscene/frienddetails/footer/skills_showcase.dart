import 'package:flutter/material.dart';

class SkillsShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
        'Sống tại Hà Nội, Việt Nam',
        style: textTheme.headline6!.copyWith(color: Colors.white),
      ),
    );
  }
}
