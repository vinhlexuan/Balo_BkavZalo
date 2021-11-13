import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:zalo/screens/login.dart';

class ConfirmRegisterScreen extends StatefulWidget {
  final String phoneNumber;

  ConfirmRegisterScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<ConfirmRegisterScreen> {
  String? code;

  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nhập mã kích hoạt")),
      body: Column(
        children: [
          Container(
            decoration: new BoxDecoration(color: Colors.grey[200]),
            child: Text(
              "Vui lòng không chia sẻ mã xác thực để tránh mất tài khoản",
              textAlign: TextAlign.left,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 15),
          ),
          Container(
            child: Icon(
              Icons.phone,
              color: Colors.green[400],
              size: 36.0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFBBDDFF))),
            margin: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.center,
            width: 48,
            height: 48,
          ),
          Container(
            child: Text(
              "Đang gọi đến số (+84) ${widget.phoneNumber.substring(1)}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            margin: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.center,
          ),
          Container(
            child: Text("Vui lòng bắt máy để nghe mã",
                textAlign: TextAlign.center),
            margin: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.center,
          ),
          Container(
            margin: const EdgeInsets.only(left: 60, right: 60),
            child: PinFieldAutoFill(
              codeLength: 4,
              onCodeChanged: (val) {
                code = val;
              },
              autoFocus: true,
              decoration: UnderlineDecoration(
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          Container(
            child: Text("Gửi lại mã 00:40", textAlign: TextAlign.center),
            margin: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(code);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("Thành công"),
                  content: new Text("Đăng ký tài khoản thành công"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(
                                  initPhoneNumber: widget.phoneNumber,
                                )),
                        ModalRoute.withName('/'),
                      ),
                      child: const Text('Đồng ý'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }
}
