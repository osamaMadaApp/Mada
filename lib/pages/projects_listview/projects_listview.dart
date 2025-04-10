import '../../components/mada_header/mada_header.dart';
import '../../components/projects_listview_filter/projects_listview_filter.dart';
import '../../components/reset_filter/reset_filter.dart';
import '../../components/select_list/mada_select_list.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import '../../structure_main_flow/internationalization.dart';
import 'projects_listview_model.dart';

class ProjectsListview extends StatelessWidget {
  const ProjectsListview(
      {super.key, this.keyTitle, this.keyProjectStatus, this.keyType});

  final String? keyType;
  final String? keyProjectStatus;
  final String? keyTitle;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectsListviewModel(
          keyTitle: keyTitle,
          keyProjectStatus: keyProjectStatus,
          keyType: keyType),
      child: _ProjectsListviewWidgetState(
          keyTitle: keyTitle,
          keyProjectStatus: keyProjectStatus,
          keyType: keyType),
    );
  }
}

class _ProjectsListviewWidgetState extends StatelessWidget {
  _ProjectsListviewWidgetState(
      {this.keyTitle, this.keyProjectStatus, this.keyType});

  final String? keyType;
  final String? keyProjectStatus;
  final String? keyTitle;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ProjectsListviewModel model =
        Provider.of<ProjectsListviewModel>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: MadaHeader(title: keyTitle ?? ''),
      backgroundColor: FlutterMadaTheme.of(context).info,
      body: SafeArea(
          child: !model.isLoading
              ? Stack(
                  children: [
                    SizedBox(
                      height: DEVICE_HEIGHT,
                      child: RefreshIndicator(
                        onRefresh: model.onRefresh,
                        color: FlutterMadaTheme.of(context).primary,
                        backgroundColor: Colors.white,
                        child: SingleChildScrollView(
                          controller: model.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
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
                              if (model.projectStatus != 'Lands')
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: DEVICE_HEIGHT * 0.02,
                                  ),
                                  child: SelectList(
                                      items: model.typeFilter,
                                      textKey: keyName,
                                      selectedItem: model.selectedTypeFilter,
                                      onTap: model.onTypeFilterPress,
                                      borderColor: FlutterMadaTheme.of(context)
                                          .color97BE5A,
                                      borderWidth: 1,
                                      borderRadius: 22),
                                ),
                              SizedBox(height: DEVICE_HEIGHT * 0.02),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: model.onOrderByDistancePressed,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(DEVICE_WIDTH * 0.01),
                                      decoration: BoxDecoration(
                                        color: model.isCurrentLocationSelected
                                            ? FlutterMadaTheme.of(context).color97BE5A.withOpacity(0.15)
                                            : FlutterMadaTheme.of(context).colorD2D2D2.withOpacity(0.25,),
                                        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.04),
                                        border: Border.all(
                                          color: model.isCurrentLocationSelected
                                              ? FlutterMadaTheme.of(context)
                                                  .color97BE5A
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: SvgPicture.asset(iconCurrentLocation),
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.02),
                                  Expanded(
                                    child: SelectList(
                                        items: model.cities,
                                        textKey: keyName,
                                        selectedItem: model.selectedCity,
                                        onTap: model.onCityPress,
                                        borderColor:
                                            FlutterMadaTheme.of(context)
                                                .color97BE5A,
                                        borderWidth: 1,
                                        borderRadius: 22),
                                  )
                                ],
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.025),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        model.openCustomBottomSheet();
                                        showLeftSideDrawer(
                                            context: context,
                                            isDismissible: true,
                                            child: ChangeNotifierProvider.value(
                                              value: model,
                                              child: const ProjectListviewFilterSheet(),
                                            ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: DEVICE_WIDTH * 0.02,
                                          vertical: DEVICE_HEIGHT * 0.01,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              DEVICE_HEIGHT * 0.04),
                                          border: Border.all(
                                              color:
                                                  FlutterMadaTheme.of(context)
                                                      .color97BE5A),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(iconCustomFilter),
                                            SizedBox(
                                                width: DEVICE_WIDTH * 0.02),
                                            Text(
                                              model.checkFilterApplied()
                                                  ? FFLocalizations.of(context)
                                                      .getText('edit_filter')
                                                  : FFLocalizations.of(context)
                                                      .getText(
                                                          'add_custom_filter'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
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
                                    if (model.checkFilterApplied())
                                      ResetFilter(
                                        onResetFilter: model.resetFilter,
                                      )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: DEVICE_HEIGHT * 0.03,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${FFLocalizations.of(context).getText('project_result')} (${model.totalDocs})',
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
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:  isPortrait(context) ? SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 434,
                                        mainAxisSpacing: DEVICE_HEIGHT * 0.02,  // Increased spacing
                                        crossAxisSpacing: DEVICE_WIDTH * 0.001,  // Increased spacing
                                        childAspectRatio: 400 / 350,
                                      ) :  SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 434,
                                        mainAxisSpacing: DEVICE_HEIGHT * 0.02,  // Increased spacing
                                        crossAxisSpacing: DEVICE_WIDTH * 0.02,  // Increased spacing
                                        childAspectRatio: 424 / 227,
                                      ),
                                      itemCount: model.projects.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item = model.projects[index];
                                        return ProjectCard(
                                          horizontalPadding: 0,
                                          images: item[keyPhotos] ?? [],
                                          projectImage: item[keyDeveloperImage] ?? testImage,
                                          projectName: item['title'] ?? '',
                                          projectAddress: item[keyCity]== null ? '${item[keySubCommunity] ?? ''}' : '${item[keyCity]} - ${item[keySubCommunity] ?? ''}',
                                          statusText: item[keyStatus] ?? '',
                                          totalUnits: item[keyTotalUnits] ?? '',
                                          availableUnits:
                                              item[keyTotalAvailableUnits] ??
                                                  '',
                                          projectStatus:
                                              item[keyProjectStatus] ?? '',
                                          getAvailableStatusLable:
                                              item[keyGetAvailableStatusLable],
                                          projectCategory: item[keyProjectType],
                                          showProjectCategory:
                                              model.projectStatus == 'ready',
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.routeProjectDetails,
                                              arguments: {
                                                keyProjectId: item[keySlug],
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
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
    );
  }
}

// Future<Future<Object?>> showLeftSideDrawer({
//   required BuildContext context,
//   bool? isDismissible,
//   ProjectsListviewModel? controller,
// }) async {
//   return showGeneralDialog(
//     context: context,
//     barrierLabel: "Dismiss",
//     barrierDismissible: isDismissible ?? true,
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (context, animation, secondaryAnimation) => Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.75,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: FlutterMadaTheme.of(context).colorFFFFFF,
//           borderRadius: const BorderRadius.horizontal(
//             right: Radius.circular(10.0),
//           ),
//         ),
//         child: Padding(
//             padding: MediaQuery.viewInsetsOf(context),
//             child: ChangeNotifierProvider.value(
//               value: controller,
//               child: const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: ProjectListviewFilterSheet(),
//               ),
//             )),
//       ),
//     ),
//     transitionBuilder: (context, animation, secondaryAnimation, child) {
//       final slide = Tween<Offset>(
//         begin: const Offset(-1, 0),
//         end: Offset.zero,
//       ).animate(animation);
//       return SlideTransition(
//         position: slide,
//         child: child,
//       );
//     },
//   );
// }
