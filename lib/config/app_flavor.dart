import 'package:package_info_plus/package_info_plus.dart';

class AppFlavor {
  late PackageInfo packageInfo;

  Future<void> initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  String getAppName() {
    return packageInfo.appName;
  }

  String getAppVersion() {
    return packageInfo.version;
  }
}
