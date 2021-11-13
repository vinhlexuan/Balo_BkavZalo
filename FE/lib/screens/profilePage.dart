import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
          height: 360.0,
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              height: 180.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/zalo002.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('images/beluwa.jpg'),
                radius: 70.0,
              ),
              SizedBox(height: 20.0),
              Text('Duy Quang',
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0)
            ])
          ]))
    ])));
  }
}
