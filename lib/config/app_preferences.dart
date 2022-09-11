import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPreferences {
  late FlutterSecureStorage storage;

  AppPreferences() {
    getInstances();
  }

  void getInstances() {
    AndroidOptions androidOptions = const AndroidOptions(encryptedSharedPreferences: true);
    IOSOptions iosOptions = const IOSOptions();
    storage = FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  }
}
