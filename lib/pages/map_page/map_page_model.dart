import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as google_maps_cluster_manager_2;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../app_state.dart';
import '../../general_exports.dart';

class MapPageModel extends ChangeNotifier {
  MapPageModel() {
    setMapCoordinates();
  }

  dynamic data;
  GoogleMapController? mapController;
  google_maps_cluster_manager_2.ClusterManager<Place>? manager;
  Set<Marker> markers = <Marker>{};
  final List<Place> clusterItems = <Place>[];
  Map<String, dynamic> selectedMarker = <String, dynamic>{};
  bool isCardExpanded = true;
  List<dynamic> cities = FFAppState().masterDateJsonModel[keyCities];
  dynamic masterData = FFAppState().masterDateJsonModel;
  List<dynamic> realEstateDevelopers = <dynamic>[];
  List<dynamic> neighborhoods = <dynamic>[];
  Map<dynamic, dynamic> selectedCity = {};
  Map<dynamic, dynamic> selectedNeighborhood = {};
  Map<dynamic, dynamic> selectedSubCommunity = {};
  Map<dynamic, dynamic> selectedRealEstateDeveloper = {};

  Map<dynamic, dynamic> selectedTemCity = {};
  Map<dynamic, dynamic> selectedTemNeighborhood = {};
  Map<dynamic, dynamic> selectedTemSubCommunity = {};
  Map<dynamic, dynamic> selectedTemRealEstateDeveloper = {};
  List<dynamic> subCommunities = [];

  double defaultMapLong = 24.774265;
  double defaultMapLat = 46.738586;
  double zoomLevel = 9;

  bool isLoading = true;

  List<dynamic> selectedStatus = [];

  void setMapCoordinates() {
    // if (myAppController.appCountry == 'AE') {
    //   defaultMapLong =
    //       myAppController.masterData['dubaiCenterPoint'][0][keyLocation][0];
    //   defaultMapLat =
    //       myAppController.masterData['dubaiCenterPoint'][0][keyLocation][1];
    //   zoomLevel = myAppController.masterData['dubaiCenterPoint'][1]['zoom'];
    // } else if (myAppController.appCountry == 'SA') {
    //   defaultMapLong =
    //       myAppController.masterData['saudiCenterPoint'][0][keyLocation][0];
    //   defaultMapLat =
    //       myAppController.masterData['saudiCenterPoint'][0][keyLocation][1];
    //   zoomLevel = myAppController.masterData['saudiCenterPoint'][1]['zoom'];
    // }

    defaultMapLong = masterData['saudiCenterPoint'][0][keyLocation][0];
    defaultMapLat = masterData['saudiCenterPoint'][0][keyLocation][1];
    zoomLevel = masterData['saudiCenterPoint'][1]['zoom'];
    notifyListeners();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    getProjects();
    notifyListeners();
  }

  void getProjects({bool withReset = true}) {
    startLoading();
    ApiRequest(
      path: apiGetProjects,
      formatResponse: true,
      className: 'MapScreenController/getProjects',
      queryParameters: {
        keyCityId: selectedCity[keyID],
        keyNeighborhoodId: selectedNeighborhood[keyID],
        keyProjectDevelopers: selectedRealEstateDeveloper[keyName],
        keySubCommunityId: selectedSubCommunity[keyID],
        keyAvailableStatus: selectedStatus.map((item) => item['key']).join(',')
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        if (withReset) {
          this.data = data[keyResults];
        }

        isLoading = false;
        markers.clear();
        dismissLoading();
        if (!response[keySuccess]) {
          markers.clear();
          // setupClusterManager(items: []);
        } else {
          if (realEstateDevelopers.isEmpty) {
            realEstateDevelopers.addAll(data[keyResults][keyProjectDevelopers]);
          }
          // setupClusterManager(items: response[keyResults][keyFinalData]);
        }
        for (final dynamic item in response[keyResults][keyFinalData]) {
          final bool isProject = item[keyType] == keyProject;
          await markers.addLabelMarker(
            LabelMarker(
              label: isProject ? item[keyTitle] : item[keyPrice].toString(),
              // : '${item[keyPrice].toString().substring(0, item[keyPrice].toString().length - 3)} ${'k'.tr}',
              textStyle: const TextStyle(
                color: Color(AppColors.black),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              markerId: MarkerId(item['_id']),
              position: LatLng(
                item[keyLocation][keyCoordinates][1] ?? 0.0,
                item[keyLocation][keyCoordinates][0] ?? 0.0,
              ),
              backgroundColor: Color(
                isProject ? AppColors.green8 : AppColors.white,
              ),
              borderColor: Color(
                isProject ? AppColors.green3 : AppColors.green,
              ),
              onTap: () async {
                selectedMarker = item;
                isCardExpanded = true;
                consoleLogPretty(selectedMarker, key: 'selectedMarker');
                notifyListeners();
              },
            ),
          );
        }
        // final List<LatLng> itemsToInclude = markers.map((Marker marker) {
        //   return marker.position;
        // }).toList();
        // fitCameraBasedOnLatLngList(mapController, itemsToInclude);
        notifyListeners();
      },
    );
  }

  Future<void> onCameraMove(CameraPosition position) async {
    manager?.onCameraMove(position);
  }

  void onCameraIdle() {
    manager?.updateMap();
  }

  void setupClusterManager({
    bool shouldFitCamera = true,
    List<dynamic> items = const <dynamic>[],
  }) {
    selectedMarker = <String, dynamic>{};
    clusterItems.clear();
    if (items.isNotEmpty) {
      for (final dynamic item in items) {
        clusterItems.add(getPlaceFromProject(item));
      }
    }
    manager = google_maps_cluster_manager_2.ClusterManager<Place>(
      clusterItems,
      (Set<Marker> markers) {
        this.markers = markers;
        notifyListeners();
      },
      markerBuilder: markerBuilder,
    );
    // if (shouldFitCamera) {
    //   final List<LatLng> itemsToInclude = clusterItems.map((Place item) {
    //     return item.latLng;
    //   }).toList();
    //   fitCameraBasedOnLatLngList(mapController, itemsToInclude);
    // }
    manager!.setMapId(mapController!.mapId);
  }

  Place getPlaceFromProject(dynamic item) => Place(
        data: item,
        latLng: LatLng(
          item[keyLocation][keyCoordinates][1] ?? 0.0,
          item[keyLocation][keyCoordinates][0] ?? 0.0,
        ),
      );

  // Marker builder for clustered items and single items
  Future<Marker> Function(google_maps_cluster_manager_2.Cluster<Place>)
      get markerBuilder => (google_maps_cluster_manager_2
              .Cluster<google_maps_cluster_manager_2.ClusterItem>
              cluster) async {
            final dynamic place = cluster.items.first;
            if (cluster.isMultiple) {
              BitmapDescriptor bitmapDescriptor =
                  BitmapDescriptor.defaultMarker;
              bitmapDescriptor = await getLabeledClusterBitmap(
                text: cluster.count.toString(),
              );
              return Marker(
                markerId: MarkerId(cluster.getId()),
                position: cluster.location,
                anchor: const Offset(0.5, 0.5),
                onTap: () {
                  if (!cluster.isMultiple) {
                    selectedMarker = place.data;
                    notifyListeners();
                    consoleLogPretty(selectedMarker);
                  }
                },
                icon: bitmapDescriptor,
              );
            } else {
              double logicalSize = 170;
              double imageSize = 600;
              if (place.data[keyTitle].length <= 10) {
                logicalSize = 110;
                imageSize = 300;
              } else if (place.data[keyTitle].length <= 20) {
                logicalSize = 160;
                imageSize = 400;
              }
              BitmapDescriptor bitmapDescriptor =
                  BitmapDescriptor.defaultMarker;
              if (place.data['isExclusive']) {
                bitmapDescriptor = await WidgetToExclusiveMarker(
                  text: place.data[keyTitle],
                  developerName: place.data[keyDeveloperName],
                  image: place.data[keyDeveloperImage],
                ).toBitmapDescriptor(
                  logicalSize: const Size(220, 220),
                  imageSize: const Size(600, 600),
                );
              } else {
                bitmapDescriptor = await WidgetToMarker(
                  text: place.data[keyTitle],
                  image: place.data[keyDeveloperImage],
                ).toBitmapDescriptor(
                  logicalSize: Size(logicalSize, logicalSize),
                  imageSize: Size(imageSize, imageSize),
                );
              }
              return Marker(
                markerId: MarkerId(cluster.getId()),
                position: cluster.location,
                anchor: const Offset(0.5, 0.5),
                onTap: () {
                  if (!cluster.isMultiple) {
                    selectedMarker = place.data;
                    notifyListeners();
                    consoleLogPretty(selectedMarker);
                  }
                },
                icon: bitmapDescriptor,
              );
            }
          };

  void onMapTapped(LatLng position) {
    // if (selectedTopCardIndex == 1) {
    //   if (currentLocationMarker != null) {
    //     currentLocationMarker = currentLocationMarker!.copyWith(
    //       positionParam: position,
    //     );
    //     manager?.updateMap();
    //     onDirectionPressed(
    //       selectedMarker[keyLocationLat],
    //       selectedMarker[keyLocationLong],
    //       currentLocationMarker!.position.latitude,
    //       currentLocationMarker!.position.longitude,
    //     );
    //   }
    // }
  }

  void getNeighborhood(dynamic selectedCity, {bool withLoading = false}) {
    if (withLoading) {
      startLoading();
    }

    neighborhoods.clear();

    ApiRequest(
      path: apiCommunities,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      method: ApiMethods.post,
      formatResponse: true,
      body: {
        keyCityId: selectedCity[keyID],
      },
      className: 'ProjectsListviewController/getNeighborhood',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        neighborhoods.addAll(data[keyResults]);
        selectedNeighborhood = {};
        notifyListeners();
      },
    );
  }

  void getSubCommunities(dynamic community, {bool withLoading = true}) {
    if (withLoading) {
      startLoading();
    }

    subCommunities.clear();

    ApiRequest(
      path: apiCommunities,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      className: 'RequestYourPropertyController/getCommunities',
      body: {
        keyNeighborhoodId: community[keyID],
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        if (response[keyResults].isNotEmpty) {
          subCommunities.addAll(response[keyResults]);
        }
        dismissLoading();
        notifyListeners();
      },
    );
  }

  void onSubCommunityTemPress(dynamic subCommunity) {
    if (selectedTemSubCommunity != subCommunity) {
      selectedTemSubCommunity = subCommunity;
    } else {
      selectedTemSubCommunity = {};
    }
    consoleLog(selectedTemSubCommunity);
    notifyListeners();
  }

  onSelectTempCity(dynamic city) {
    if (selectedTemCity == city) {
      selectedTemCity = {};
      neighborhoods.clear();
      selectedTemNeighborhood = {};
    } else {
      selectedTemCity = city;
      getNeighborhood(selectedTemCity, withLoading: true);
    }

    consoleLog(selectedTemCity, key: 'selectedTempCity');

    notifyListeners();
  }

  void onTemNeighborhoodPress(dynamic neighborhood) {
    if (selectedTemNeighborhood == neighborhood) {
      selectedTemNeighborhood = {};
    } else {
      selectedTemNeighborhood = neighborhood;
    }

    getSubCommunities(selectedTemNeighborhood);

    consoleLog(selectedTemNeighborhood, key: 'selectedTemNeighborhood');
    notifyListeners();
  }

  void onTemRealEstateDeveloperPress(dynamic realEstateDeveloper) {
    if (selectedTemRealEstateDeveloper == realEstateDeveloper) {
      selectedTemRealEstateDeveloper = {};
    } else {
      selectedTemRealEstateDeveloper = realEstateDeveloper;
    }

    consoleLog(
      selectedTemRealEstateDeveloper,
      key: 'selectedTemRealEstateDeveloper',
    );
    notifyListeners();
  }

  void onCardExpandPress() {
    isCardExpanded = !isCardExpanded;
    notifyListeners();
  }

  void onApplyFilterPress() {
    selectedCity = selectedTemCity;

    selectedNeighborhood = selectedTemNeighborhood;

    selectedRealEstateDeveloper = selectedTemRealEstateDeveloper;

    selectedSubCommunity = selectedTemSubCommunity;

    consoleLog(selectedSubCommunity);

    getProjects();
  }

  bool getFilterActiveStatus() {
    return (selectedCity.isNotEmpty ||
        selectedNeighborhood.isNotEmpty ||
        selectedRealEstateDeveloper.isNotEmpty);
  }

  void resetFilter() {
    selectedCity = {};

    selectedNeighborhood = {};

    selectedSubCommunity = {};

    selectedRealEstateDeveloper = {};

    neighborhoods.clear();
    subCommunities.clear();

    getProjects();
  }

  void addToSelectedStatus(dynamic status) {
    if (selectedStatus.contains(status)) {
      selectedStatus.remove(status);
    } else {
      selectedStatus.add(status);
    }

    getProjects(withReset: false);
    notifyListeners();
  }

  void clearSelectedStatus() {
    selectedStatus.clear();
    getProjects();
    notifyListeners();
  }
}
