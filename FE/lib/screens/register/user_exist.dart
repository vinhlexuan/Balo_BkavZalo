import 'package:flutter/material.dart';
import 'package:zalo/screens/login.dart';

class UserExistScreen extends StatelessWidget {
  final String phoneNumber;

  const UserExistScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    String phoneNumberFormated = formatPhoneNumber(phoneNumber);
    return Scaffold(
        appBar: AppBar(
          title: Text("Xác nhận tài khoản"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                      child: Text(
                        "Đã tồn tại 1 tài khoản Zalo được gắn với số điện thoại $phoneNumberFormated",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(top: 16, bottom: 26)),
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: const Text('AH'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Column(
                        children: [
                          Text("Họ tên",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("$phoneNumberFormated",
                              style: TextStyle(color: Colors.grey[400])),
                        ],
                      )),
                  RichText(
                    text: TextSpan(
                      children: const <TextSpan>[
                        TextSpan(text: 'Nếu '),
                        TextSpan(
                            text: 'Họ Tên',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' là tài khoản của bạn'),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreen(initPhoneNumber: phoneNumber)),
                            ModalRoute.withName('/'));
                      },
                      child: Text("đăng nhập tại đây"))
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30),
                    primary: Colors.blue,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(16),
                    )),
                child: Text('Dùng số điện thoại khác'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/register',
                    ModalRoute.withName('/'),
                  );
                },
              ),
              margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
            ),
          ],
        ));
  }

  String formatPhoneNumber(String phoneNumber) {
    String first = phoneNumber.substring(1, 4);
    String second = phoneNumber.substring(4, 7);
    String third = phoneNumber.substring(7, 10);
    return "(+84) $first $second $third";
  }
}
