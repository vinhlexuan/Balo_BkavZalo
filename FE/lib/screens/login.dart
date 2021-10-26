import 'package:flutter/material.dart';
import 'package:zalo/apis/auth_api.dart';
import 'package:zalo/models/api_exception.dart';
import 'package:zalo/models/login_info.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _LoginFormState extends State<LoginScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final phoneNumber = TextEditingController();
  final passWord = TextEditingController();

  String _phoneNumber = '';
  String _passWord = '';
  bool _obscureText = false;

  AuthAPI _authAPI = AuthAPI();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumber.dispose();
    passWord.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              obscureText: !_obscureText,
              decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _toggle();
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.red,
                    ),
                  )))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _passWord = passWord.text;
          _phoneNumber = phoneNumber.text;

          try {
            LoginInfo loginInfo = await _authAPI.login(_phoneNumber, _passWord);
            print(loginInfo.id);
            Navigator.pushNamed(context, '/main');
          } on APIException catch (e) {
            print('${e.code} ${e.message}');
          } catch (e) {
            print(e.toString());
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
