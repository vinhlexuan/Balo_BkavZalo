import 'package:flutter/material.dart';

const TextStyle headingStyle = TextStyle(fontSize: 36, color: Colors.blue);
const TextStyle bigwordStyle = TextStyle(fontSize: 28);
const TextStyle smallwordStyle = TextStyle(fontSize: 22);

final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 25),
    minimumSize: const Size(350, 70),
    maximumSize: const Size(400, 70));

Widget loginSelection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Đăng nhập'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('Đăng ký'),
          ),
        ),
      ],
    ),
  );
}

Widget textSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: const Text(
            "Chat nhóm tiện ích",
            style: bigwordStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: const Text(
            "Hãy cũng nhau trao đổi, giữ liên lạc với gia đình, bạn bè, đồng nghiệp",
            style: smallwordStyle,
          ),
        )
      ],
    ),
  );
}

class IntroScene extends StatelessWidget {
  const IntroScene({Key? key}) : super(key: key);
  static const String _title = 'Zalo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text(
              _title,
              style: headingStyle,
            )),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Column(children: [
              Image.asset(
                'images/zalo_head.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              textSection(context),
              loginSelection(context),
              const Text("Tiếng việt"),
            ]),
          ),
        ));
  }
}
