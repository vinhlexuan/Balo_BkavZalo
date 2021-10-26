import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _RegisterFormState extends State<RegisterScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final fullName = TextEditingController();
  // final passWord = TextEditingController();

  String _fullName = '';
  // String _passWord = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fullName.dispose();
    // passWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng ký"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: fullName,
            decoration: InputDecoration(
              labelText: 'Tên đầy đủ',
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fullName = fullName.text;
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
