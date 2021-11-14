import 'dart:convert';

class AuthHelper {
  AuthHelper._privateConstructor();
  static final AuthHelper _instance = AuthHelper._privateConstructor();
  factory AuthHelper() {
    return _instance;
  }

  RegExp _phoneNumberReg = new RegExp(
    r"^0\d{9}$",
    caseSensitive: false,
    multiLine: false,
  );
  RegExp _passwordReg = new RegExp(
    r"^[a-zA-Z0-9]{6,10}$",
    caseSensitive: false,
    multiLine: false,
  );

  bool checkPhoneNumber(String phoneNumber) {
    return _phoneNumberReg.hasMatch(phoneNumber);
  }

  bool checkPassword(String password) {
    return _passwordReg.hasMatch(password);
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
