import 'package:location/location.dart';

import '../general_exports.dart';

final Location location = Location();
LocationData? locationData;

Future<LocationData?> getCurrentLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  startLoading();

  try {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();
  } catch (e) {
    dismissLoading();
  }

  dismissLoading();

  return locationData;
}
