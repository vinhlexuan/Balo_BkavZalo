import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zalo/models/friend.dart';
import 'package:zalo/screens/intro.dart';
import 'package:zalo/subscene/frienddetails/friend_details_page.dart';
import 'package:zalo/subscene/frienddetails/self_details_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "";
  String? _avatar = null;

  @override
  void initState() {
    super.initState();
    loadState();
  }

  Future<Map<String, dynamic>> loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonInfo = prefs.getString('login_info') ?? "{'user_id': ''}";
    Map<String, dynamic> userMap = json.decode(jsonInfo);
    setState(() {
      _username = userMap['usename'] ?? 'Anonymous';
      _avatar = userMap['avatar'];
    });
    return userMap;
  }

  // void loadState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String jsonInfo =
  //       prefs.getString('user_info') ?? "{'username': 'Anonymous'}";

  //   Map<String, dynamic> userMap = json.decode(jsonInfo);
  //   print(userMap);
  //   setState(() {
  //     _username = userMap['usename'] ?? 'Anonymous';
  //     _avatar = userMap['avatar'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: SingleChildScrollView(
    //         child: Column(children: <Widget>[
    //   Container(
    //       height: 360.0,
    //       child: Stack(children: <Widget>[
    //         Container(
    //           margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
    //           height: 180.0,
    //           decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   image: AssetImage('assets/zalo002.jpg'),
    //                   fit: BoxFit.cover),
    //               borderRadius: BorderRadius.circular(10.0)),
    //         ),
    //         Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
    //           CircleAvatar(
    //             backgroundImage: AssetImage('images/beluwa.jpg'),
    //             radius: 70.0,
    //           ),
    //           SizedBox(height: 20.0),
    //           Text('Duy Quang',
    //               style:
    //                   TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
    //           SizedBox(height: 20.0)
    //         ])
    //       ]))
    // ])));
    Friend fr_temp = new Friend(
      avatar: '',
      name: _username,
      email: '',
      location: 'Ha noi',
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(_username),
            onTap: () => {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (c) {
                    return new SelfDetailsPage(fr_temp, avatarTag: '');
                  },
                ),
              )
            },
            leading: CircleAvatar(
              backgroundImage:
                  _avatar != null ? NetworkImage(_avatar ?? '') : null,
              // child: _avatar == null ? Text(_username.substring(0, 1)) : null,
              child: _avatar == null ? Text("A") : null,
              radius: 20.0,
            ),
          ),
          // ListTile(title: Text("Ví QR"), onTap: () {}),
          // ListTile(title: Text("Cloud của tôi"), onTap: () {}),
          ListTile(title: Text("Tài khoản và bảo mật"), onTap: () {}),
          // ListTile(title: Text("Quyền riêng tư"), onTap: () {}),
          ListTile(
            title: Text("Đăng xuất"),
            onTap: () async {
              await deleteInfo();
              // Navigator.push<void>(
              //   context,
              //   MaterialPageRoute<void>(
              //       builder: (BuildContext context) => const IntroScreen()),
              // );

              // Navigator.pushReplacementNamed(context, "/");

              // Navigator.pushNamed(context, "/login");
              // Navigator.pushNamed(context, "/");

              Navigator.pushNamedAndRemoveUntil(
                  context, "/", ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    ));
  }

  Future<void> deleteInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("user_info");
  }
}
