import 'package:flutter/material.dart';
import 'package:zalo/screens/intro.dart';
import 'package:zalo/screens/login.dart';
import 'package:zalo/screens/main_screen.dart';
import 'package:zalo/screens/register.dart';
// import 'package:zalo/screens/chat.dart';

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
        '/': (context) => const IntroScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => MainScreen(),
        // '/conv': (context) => const ChatPage(),
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
