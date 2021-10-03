import 'package:flutter/material.dart';
import 'package:zalo/scene/intro.dart';
import 'package:zalo/scene/login.dart';
import 'package:zalo/scene/mainscene.dart';
import 'package:zalo/scene/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const IntroScene(),
        '/login': (context) => const LoginScene(),
        '/register': (context) => const RegisterScene(),
        '/main': (context) => const MainScene(),
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
