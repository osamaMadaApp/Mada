import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../general_exports.dart';

const String googleApiKey = 'AIzaSyD3RTCNGT17mK8ulU9ULCi5XFNdKOyKT5E';

void animateGoogleMapCamera(
  GoogleMapController mapController,
  double lat,
  double lng, {
  double? zoom = 18.0,
  // Not implemented yet in google map flutter https://github.com/flutter/flutter/issues/39810
  int? duration = 4000,
}) {
  mapController.animateCamera(
    CameraUpdate.newLatLngZoom(
      LatLng(lat, lng),
      zoom!,
    ),
  );
}

Future<String?> getDistrictFromCoordinates(
  double latitude,
  double longitude,
) async {
  final String url =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final List<dynamic> results = data['results'];

        // Loop through address components to find the district
        for (final result in results) {
          for (final component in result['address_components']) {
            if ((component['types'] as List)
                .contains('administrative_area_level_2')) {
              return component['long_name']; // District name
            }
          }
        }
      } else {
        print('Error: ${data['status']}');
      }
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }

  return null; // Return null if no district found
}

// This function return a bitmap descriptor for cluster marker, it shows the number of markers in cluster
Future<BitmapDescriptor> getLabeledClusterBitmap({
  int size = 135,
  String? text,
}) async {
  final PictureRecorder pictureRecorder = PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint fillPaint = Paint()..color = const Color(AppColors.green);
  final Paint borderPaint = Paint()
    ..strokeWidth = 0
    ..color = const Color(AppColors.primary).withOpacity(0.3)
    ..style = PaintingStyle.stroke;

  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, fillPaint);
  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.15, borderPaint);

  final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: text,
    style: TextStyle(
      fontSize: size / 2,
      color: const Color(AppColors.white),
      fontWeight: FontWeight.bold,
    ),
  );
  painter.layout();
  painter.paint(
    canvas,
    Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
  );

  final dynamic img = await pictureRecorder.endRecording().toImage(size, size);
  final ByteData? data = await img.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}

void fitCameraBasedOnLatLngList(
  GoogleMapController? mapController,
  List<LatLng> latLngList, {
  bool withAnimation = true,
  double padding = 20.0,
}) {
  if (latLngList.length == 1) {
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(latLngList.first, 16.0),
    );
    return;
  }
  LatLngBounds? bounds;
  if (latLngList.isNotEmpty) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;
    for (LatLng latLng in latLngList) {
      minLat = min(minLat, latLng.latitude);
      maxLat = max(maxLat, latLng.latitude);
      minLng = min(minLng, latLng.longitude);
      maxLng = max(maxLng, latLng.longitude);
    }
    bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
    if (withAnimation) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, padding),
      );
    } else {
      mapController!.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    }
  }
}
