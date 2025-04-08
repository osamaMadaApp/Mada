import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app_state.dart';
import '../../general_exports.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<MapPageModel>(
          create: (BuildContext context) => MapPageModel(),
        ),
      ],
      child: const MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapPageModel mapPageModel = Provider.of<MapPageModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: <Widget>[
          GoogleMap(
            indoorViewEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: mapPageModel.onMapCreated,
            onCameraMove: mapPageModel.onCameraMove,
            onCameraIdle: mapPageModel.onCameraIdle,
            markers: mapPageModel.markers,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                mapPageModel.defaultMapLat,
                mapPageModel.defaultMapLong,
              ),
              zoom: mapPageModel.zoomLevel.toDouble(),
            ),
            // polylines: Set<Polyline>.of(mapPageModel.polylines.values),
            onTap: mapPageModel.onMapTapped,
          ),
          Container(
            height: DEVICE_HEIGHT * 0.18,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(250, 255, 255, 255),
                  Color.fromARGB(250, 255, 255, 255),
                  Color.fromARGB(50, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: DEVICE_HEIGHT * 0.02,
            left: DEVICE_HEIGHT * 0.02,
            right: DEVICE_HEIGHT * 0.02,
            child: HeaderWidget(
              profilePicture: FFAppState().userModel[keyProfilePic],
              title: FFAppState().userModel[keyFirstName],
            ),
          ),
          if (!mapPageModel.isLoading &&
              mapPageModel.data?[keyStatusValue] != null)
            Positioned(
              top: DEVICE_HEIGHT * 0.1,
              child: SizedBox(
                height: DEVICE_HEIGHT * 0.045,
                width: DEVICE_WIDTH,
                child: ListView.builder(
                  itemCount: mapPageModel.data[keyStatusValue].length +
                      (mapPageModel.selectedStatus.isNotEmpty ? 1 : 0),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.02,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= mapPageModel.data[keyStatusValue].length) {
                      return StatusCard(
                        isReset: true,
                        onPressed: (status) {
                          mapPageModel.clearSelectedStatus();
                        },
                      );
                    }
                    final item = mapPageModel.data[keyStatusValue][index];
                    return StatusCard(
                      item: item,
                      isSelected: mapPageModel.selectedStatus.contains(item),
                      onPressed: mapPageModel.addToSelectedStatus,
                    );
                  },
                ),
              ),
            ),
          if (mapPageModel.selectedMarker.isNotEmpty)
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Stack(
                children: <Widget>[
                  if (mapPageModel.isCardExpanded)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ProjectCard(
                          forceShowProjectImage: true,
                          images: mapPageModel.selectedMarker[keyPhotos] ?? [],
                          projectImage:
                              mapPageModel.selectedMarker[keyDeveloperImage],
                          maxLines: 2,
                          projectName:
                              mapPageModel.selectedMarker[keyTitle] ?? '',
                          projectAddress: mapPageModel.selectedMarker[keyCity] +
                              '-' +
                              '${mapPageModel.selectedMarker[keySubCommunity] ?? ''}',
                          statusText:
                              mapPageModel.selectedMarker[keyStatus] ?? '',
                          totalUnits:
                              mapPageModel.selectedMarker[keyTotalUnits] ?? '',
                          availableUnits: mapPageModel
                                  .selectedMarker[keyTotalAvailableUnits] ??
                              '',
                          horizontalPadding: DEVICE_WIDTH * 0.01,
                          verticalPadding: DEVICE_HEIGHT * 0.01,
                          onTap: () {
                            if (mapPageModel.selectedMarker[keyType] ==
                                keyProject) {
                              Navigator.pushNamed(
                                context,
                                Routes.routeProjectDetails,
                                arguments: {
                                  keyProjectId:
                                      mapPageModel.selectedMarker[keySlug],
                                },
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                Routes.routePropertyDetails,
                                arguments: {
                                  keyPropertyId:
                                      mapPageModel.selectedMarker[keyID],
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: mapPageModel.onCardExpandPress,
                    child: Container(
                      width: DEVICE_WIDTH,
                      height: DEVICE_HEIGHT * 0.04,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(AppColors.primary),
                      ),
                      child: Center(
                        child: Icon(
                          mapPageModel.isCardExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    this.item,
    this.isSelected = false,
    this.onPressed,
    this.isReset = false,
  });
  final dynamic item;
  final bool isSelected;
  final Function(dynamic item)? onPressed;
  final bool isReset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onPressed?.call(item);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: DEVICE_HEIGHT * 0.015,
              vertical: DEVICE_HEIGHT * 0.009,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
              border: Border.all(
                color: Color(
                  isReset ? AppColors.primary : AppColors.transparent,
                ),
              ),
              color: Color(
                int.parse(
                  hexToColor(
                    item?[keyColorCode] ?? '#FFFFFF',
                  ),
                ),
              ).withOpacity(isSelected ? 1 : 0.25),
            ),
            child: Center(
              child: Row(
                children: [
                  if (isReset)
                    SvgPicture.asset(
                      iconRedRoundedClose,
                      fit: BoxFit.cover,
                      height: DEVICE_HEIGHT * 0.02,
                    )
                  else
                    Container(
                      height: DEVICE_HEIGHT * 0.04,
                      width: DEVICE_WIDTH * 0.01,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(DEVICE_HEIGHT * 0.02),
                        color: isSelected
                            ? const Color(AppColors.white)
                            : Color(
                                int.parse(
                                  hexToColor(
                                    item?[keyColorCode] ?? '#FFFFFF',
                                  ),
                                ),
                              ),
                      ),
                    ),
                  SizedBox(
                    width: DEVICE_WIDTH * 0.01,
                  ),
                  Text(
                    isReset
                        ? FFLocalizations.of(context).getText('reset')
                        : item?[keyValue] ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isReset
                              ? const Color(AppColors.red)
                              : isSelected
                                  ? const Color(AppColors.white)
                                  : Color(
                                      int.parse(
                                        hexToColor(
                                          item?[keyColorCode] ?? '#FFFFFF',
                                        ),
                                      ),
                                    ),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: DEVICE_WIDTH * 0.01)
      ],
    );
  }
}
