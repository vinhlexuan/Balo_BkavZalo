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
}
