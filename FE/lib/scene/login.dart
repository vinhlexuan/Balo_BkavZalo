import 'package:flutter/material.dart';

class LoginScene extends StatelessWidget {
  const LoginScene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Đăng nhập',
      home: LoginForm(),
    );
  }
}

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _LoginFormState extends State<LoginForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final phoneNumber = TextEditingController();
  final passWord = TextEditingController();

  String _phoneNumber = '';
  String _passWord = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumber.dispose();
    passWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Đăng nhập"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: phoneNumber,
            decoration: InputDecoration(
              labelText: 'Số điện thoại',
            ),
          ),
          TextField(
              controller: passWord,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
              )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _passWord = passWord.text;
          _phoneNumber = phoneNumber.text;
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
