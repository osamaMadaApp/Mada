import 'package:flutter/scheduler.dart';
import '../../components/reset_filter/reset_filter.dart';
import '../../components/select_list/mada_select_list.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import 'projects_listview_model.dart';

class ProjectsListview extends StatefulWidget {
  const ProjectsListview(
      {super.key, this.keyTitle, this.keyProjectStatus, this.keyType});

  final String? keyType;
  final String? keyProjectStatus;
  final String? keyTitle;

  @override
  State<ProjectsListview> createState() => _ProjectsListviewWidgetState();
}

class _ProjectsListviewWidgetState extends State<ProjectsListview>
    with TickerProviderStateMixin {
  late ProjectsListviewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<ProjectsListviewModel>();
    _model.onInit(widget.keyTitle ?? '', widget.keyProjectStatus ?? '');
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.onReady();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model = context.watch<ProjectsListviewModel>();
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterMadaTheme.of(context).info,
          body: SafeArea(
              top: true,
              child: !_model.isLoading
                  ? Stack(
                      children: [
                        SizedBox(
                          height: DEVICE_HEIGHT,
                          child: RefreshIndicator(
                            onRefresh: _model.onRefresh,
                            color: FlutterMadaTheme.of(context).primary,
                            backgroundColor: Colors.white,
                            child: SingleChildScrollView(
                              controller: _model.scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: DEVICE_WIDTH * 0.02,
                                vertical: DEVICE_HEIGHT * 0.02,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context)
                                        .getText('quick_filter'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  if (_model.projectStatus != 'Lands')
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: DEVICE_HEIGHT * 0.02,
                                      ),
                                      child: SelectList(
                                        items: _model.typeFilter,
                                        textKey: keyName,
                                        selectedItem: _model.selectedTypeFilter,
                                        onTap: _model.onTypeFilterPress,
                                        borderColor:
                                            FlutterMadaTheme.of(context)
                                                .color97BE5A,
                                        borderWidth: 1,
                                      ),
                                    ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.02),
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.all(DEVICE_WIDTH * 0.01),
                                        decoration: BoxDecoration(
                                          color:
                                              _model.isCurrentLocationSelected
                                                  ? FlutterMadaTheme.of(context)
                                                      .color97BE5A //colorD2D2D2
                                                      .withOpacity(0.15)
                                                  : FlutterMadaTheme.of(context)
                                                      .colorD2D2D2
                                                      .withOpacity(
                                                        0.25,
                                                      ),
                                          borderRadius: BorderRadius.circular(
                                              DEVICE_HEIGHT * 0.04),
                                          border: Border.all(
                                            color: _model
                                                    .isCurrentLocationSelected
                                                ? FlutterMadaTheme.of(context)
                                                    .color97BE5A
                                                : Colors.transparent,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                            iconCurrentLocation),
                                      ),
                                      SizedBox(width: DEVICE_WIDTH * 0.02),
                                      Expanded(
                                        child: SelectList(
                                          items: _model.cities,
                                          textKey: keyName,
                                          selectedItem: _model.selectedCity,
                                          onTap: _model.onCityPress,
                                          borderColor:
                                              FlutterMadaTheme.of(context)
                                                  .color97BE5A,
                                          borderWidth: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.025),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: _model.openCustomBottomSheet,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: DEVICE_WIDTH * 0.02,
                                              vertical: DEVICE_HEIGHT * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      DEVICE_HEIGHT * 0.04),
                                              border: Border.all(
                                                  color: FlutterMadaTheme.of(
                                                          context)
                                                      .color97BE5A),
                                            ),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    iconCustomFilter),
                                                SizedBox(
                                                    width: DEVICE_WIDTH * 0.02),
                                                Text(
                                                  _model.checkFilterApplied()
                                                      ? FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'edit_filter')
                                                      : FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'add_custom_filter'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                SizedBox(
                                                    width: DEVICE_WIDTH * 0.01),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // if (controller
                                        //     .selectedFilteredPropertyPurpose
                                        //     .isNotEmpty)
                                        //   SelectedFilterItem(
                                        //     itemText: controller
                                        //             .selectedFilteredPropertyPurpose[
                                        //         keyValue],
                                        //     onItemClose: () {
                                        //       controller
                                        //           .selectedFilteredPropertyPurpose = {};
                                        //       controller.filterMap
                                        //           .remove(keyPurposeType);
                                        //       controller.getProjectsWithFiltering();
                                        //     },
                                        //   ),
                                        // if (controller.selectedTypeFilter != null &&
                                        //     controller
                                        //         .selectedTypeFilter.isNotEmpty)
                                        //   SelectedFilterItem(
                                        //     itemText: controller
                                        //         .selectedTypeFilter[keyName],
                                        //     onItemClose: () {
                                        //       controller.onTypeFilterPress(
                                        //         controller.selectedTypeFilter,
                                        //       );
                                        //     },
                                        //   ),
                                        // if (controller.selectedCity != null &&
                                        //     controller.selectedCity.isNotEmpty)
                                        //   SelectedFilterItem(
                                        //     itemText:
                                        //         controller.selectedCity[keyName],
                                        //     onItemClose: () {
                                        //       controller.onCityPress(
                                        //         controller.selectedCity,
                                        //       );
                                        //     },
                                        //   ),
                                        // if (controller
                                        //     .selectedNeighborhood.isNotEmpty)
                                        //   SelectedFilterItem(
                                        //     itemText: controller
                                        //         .selectedNeighborhood[keyName],
                                        //     onItemClose: () {
                                        //       controller.selectedNeighborhood = {};
                                        //       controller.filterMap
                                        //           .remove(keyNeighborhoodId);
                                        //       controller.getProjectsWithFiltering();
                                        //     },
                                        //   ),
                                        // if (controller
                                        //     .selectedRealEstateDeveloper.isNotEmpty)
                                        //   SelectedFilterItem(
                                        //     itemText: controller
                                        //             .selectedRealEstateDeveloper[
                                        //         keyName],
                                        //     onItemClose: () {
                                        //       controller
                                        //           .selectedRealEstateDeveloper = {};
                                        //       controller.filterMap
                                        //           .remove(keyDeveloper);
                                        //       controller.getProjectsWithFiltering();
                                        //     },
                                        //   ),
                                        // if (controller
                                        //     .selectedRoomsNumber.isNotEmpty)
                                        //   SelectedFilterItem(
                                        //     itemText: controller
                                        //         .selectedRoomsNumber[keyValue],
                                        //     onItemClose: () {
                                        //       controller.selectedRoomsNumber = {};
                                        //       controller.filterMap
                                        //           .remove(keyBedrooms);
                                        //       controller.getProjectsWithFiltering();
                                        //     },
                                        //   ),
                                        SizedBox(
                                          width: DEVICE_WIDTH * 0.02,
                                        ),
                                        if (_model.checkFilterApplied())
                                          ResetFilter(
                                            onResetFilter: _model.resetFilter,
                                          )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: DEVICE_HEIGHT * 0.03,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${FFLocalizations.of(context).getText('project_result')} (${_model.totalDocs})',
                                          style: TextStyle(
                                            color: FlutterMadaTheme.of(context)
                                                .color000000,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: DEVICE_HEIGHT * 0.01,
                                        ),
                                        ListView.builder(
                                          itemCount: _model.projects.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final item = _model.projects[index];
                                            return ProjectCard(
                                              horizontalPadding: 0,
                                              images: item[keyPhotos] ?? [],
                                              projectImage:
                                                  item[keyDeveloperImage] ??
                                                      testImage,
                                              projectName: item[keyTitle] ?? '',
                                              projectAddress:
                                                  '${item[keyCity]} - ${item[keySubCommunity] ?? ''}',
                                              statusText: item[keyStatus] ?? '',
                                              totalUnits:
                                                  item[keyTotalUnits] ?? '',
                                              availableUnits: item[
                                                      keyTotalAvailableUnits] ??
                                                  '',
                                              projectStatus:
                                                  item[keyProjectStatus] ?? '',
                                              getAvailableStatusLable: item[
                                                  keyGetAvailableStatusLable],
                                              projectCategory:
                                                  item[keyProjectType],
                                              showProjectCategory:
                                                  _model.projectStatus ==
                                                      'ready',
                                              onTap: () {
                                                // Get.toNamed(
                                                //   routeProjectDetails,
                                                //   arguments: item[keySlug],
                                                // );
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: DEVICE_HEIGHT * 0.05,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // if (!controller.isLoading)
                        //   Positioned(
                        //     bottom: DEVICE_HEIGHT * 0.04,
                        //     left: DEVICE_WIDTH * 0.29,
                        //     right: DEVICE_WIDTH * 0.29,
                        //     child: CustomContainerButton(
                        //       text: 'sort'.tr,
                        //       textStyle:
                        //           Theme.of(context).textTheme.bodySmall!.copyWith(
                        //                 color: const Color(AppColors.white),
                        //               ),
                        //       backgroundColor: const Color(AppColors.green3),
                        //       verticalPadding: DEVICE_HEIGHT * 0.019,
                        //       horizontalPadding: DEVICE_WIDTH * 0.1,
                        //       borderRadius: DEVICE_WIDTH * 0.08,
                        //       icon: iconSort,
                        //       onPressed: controller.onSortPressed,
                        //     ),
                        //   ),
                      ],
                    )
                  : const Center()),
        ));
  }
}
