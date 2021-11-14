import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zalo/utils/auth_helper.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _Inittate createState() => _Inittate();
}

class _Inittate extends State<FirstScreen> {
  AuthHelper _authHelper = AuthHelper();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString('token');
      String target = "/intro";
      print(token);
      if (token != null) {
        var payloadMap = _authHelper.parseJwt(token);
        var expiredTime = payloadMap['exp'];
        var now = DateTime.now().millisecondsSinceEpoch / 1000;
        if (expiredTime > now) target = "/main";
      }

      Navigator.pushReplacementNamed(context, target);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
