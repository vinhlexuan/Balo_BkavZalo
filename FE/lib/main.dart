import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zalo/screens/intro.dart';
import 'package:zalo/screens/login.dart';
import 'package:zalo/screens/main_screen.dart';
import 'package:zalo/screens/register/register.dart';
import 'package:zalo/utils/auth_helper.dart';
// import 'package:zalo/screens/chat.dart';

class MyApp extends StatelessWidget {
  final String initScreen;
  const MyApp({Key? key, this.initScreen = '/'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: initScreen,
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initScreen = await getInitScreen();

  runApp(MyApp(initScreen: initScreen));
}

Future<String> getInitScreen() async {
  String initScreen = '/';

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    if (token != null) {
      var payloadMap = AuthHelper().parseJwt(token);
      var expiredTime = payloadMap['exp'];
      var now = DateTime.now().millisecondsSinceEpoch / 1000;
      if (expiredTime > now) initScreen = "/main";
    }
  } catch (err) {
    print(err);
  }

  return initScreen;
}
