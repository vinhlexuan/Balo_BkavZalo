import 'dart:io';

class ConnectionStatus {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatus _singleton = new ConnectionStatus._internal();
  ConnectionStatus._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatus getInstance() => _singleton;

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }
}
