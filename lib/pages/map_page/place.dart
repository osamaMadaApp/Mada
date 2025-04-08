import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place with ClusterItem {
  Place({
    required this.data,
    required this.latLng,
  });
  final dynamic data;
  final LatLng latLng;

  @override
  LatLng get location => latLng;

  @override
  String toString() {
    return 'Place{data: ${data.toString()}, latLng: $latLng}';
  }
}
