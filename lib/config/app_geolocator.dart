import 'package:geolocator/geolocator.dart';

class AppGeolocator {
  bool serviceEnabled = false;
  LocationPermission? permission;

  Future<Position> getMyLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  bool hasPermission() {
    return permission != LocationPermission.denied && permission != LocationPermission.deniedForever;
  }

  Future<String?> askPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return null;
  }
}
