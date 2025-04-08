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
                              SizedBox(height: DEVICE_HEIGHT * 0.025),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      model.openCustomBottomSheet();
                                      showLeftSideDrawer(
                                          context: context,
                                          isDismissible: true,
                                          child: ChangeNotifierProvider.value(
                                            value: model,
                                            child:
                                                const ProjectListviewFilterSheet(),
                                          ));
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(DEVICE_WIDTH * 0.005),
                                      decoration: BoxDecoration(
                                        color: FlutterMadaTheme.of(context)
                                            .colorFFFFFF,
                                        borderRadius: BorderRadius.circular(
                                            DEVICE_HEIGHT * 0.04),
                                        border: Border.all(
                                          color: model.isCurrentLocationSelected
                                              ? FlutterMadaTheme.of(context)
                                                  .color97BE5A
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        iconCustomFilter,
                                        width: 25,
                                        colorFilter: ColorFilter.mode(
                                          FlutterMadaTheme.of(context)
                                              .color97BE5A,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.02),
                                  if (model.projectStatus != 'Lands')
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: DEVICE_HEIGHT * 0.02,
                                      ),
                                      child: SelectList(
                                          minHeight: 40.h,
                                          items: model.typeFilter,
                                          textKey: keyName,
                                          selectedItem:
                                              model.selectedTypeFilter,
                                          onTap: model.onTypeFilterPress,
                                          borderColor:
                                              FlutterMadaTheme.of(context)
                                                  .color97BE5A,
                                          borderWidth: 1,
                                          suffixWidget: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                if (model.checkFilterApplied())
                                                  GestureDetector(
                                                    onTap: model.resetFilter,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            DEVICE_WIDTH *
                                                                0.009,
                                                        vertical:
                                                            DEVICE_HEIGHT *
                                                                0.009,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            AppColors.white),
                                                        border: Border.all(
                                                          color: FlutterMadaTheme
                                                                  .of(context)
                                                              .color97BE5A,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                DEVICE_HEIGHT *
                                                                    0.04),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                            child: SvgPicture.asset(
                                                                iconFilterRemove),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                      0.009),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                                    'reset_filter'),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        AppFonts
                                                                            .workSans,
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                          borderRadius: 22),
                                    ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.02),
                                ],
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.025),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: model.onOrderByDistancePressed,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(DEVICE_WIDTH * 0.0055),
                                      decoration: BoxDecoration(
                                        color: model.isCurrentLocationSelected
                                            ? FlutterMadaTheme.of(context)
                                                .color97BE5A
                                                .withOpacity(0.15)
                                            : FlutterMadaTheme.of(context)
                                                .colorD2D2D2
                                                .withOpacity(
                                                  0.25,
                                                ),
                                        borderRadius: BorderRadius.circular(
                                            DEVICE_HEIGHT * 0.04),
                                        border: Border.all(
                                          color: model.isCurrentLocationSelected
                                              ? FlutterMadaTheme.of(context)
                                                  .color97BE5A
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child:
                                          SvgPicture.asset(iconCurrentLocation),
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: DEVICE_HEIGHT * 0.03,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context)
                                              .getText('latest_projects'),
                                          style: TextStyle(
                                              color: FlutterMadaTheme.of(context)
                                                  .color000000,
                                              fontSize: 20.0,
                                              fontWeight: AppFonts.w600,
                                              fontFamily: AppFonts.outfit),
                                        ),
                                        Text(
                                          '${FFLocalizations.of(context).getText('result')} ${model.totalDocs} ${FFLocalizations.of(context).getText('project')}',
                                          style: TextStyle(
                                              color: FlutterMadaTheme.of(context)
                                                  .color000000,
                                              fontSize: 20.0,
                                              fontWeight: AppFonts.w400,
                                              fontFamily: AppFonts.outfit),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate: isPortrait(context)
                                          ? SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 434,
                                              mainAxisSpacing:
                                                  DEVICE_HEIGHT * 0.02,
                                              // Increased spacing
                                              crossAxisSpacing:
                                                  DEVICE_WIDTH * 0.001,
                                              // Increased spacing
                                              childAspectRatio: 400 / 350,
                                            )
                                          : SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 434,
                                              mainAxisSpacing:
                                                  DEVICE_HEIGHT * 0.02,
                                              // Increased spacing
                                              crossAxisSpacing:
                                                  DEVICE_WIDTH * 0.02,
                                              // Increased spacing
                                              childAspectRatio: 424 / 227,
                                            ),
                                      itemCount: model.projects.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item = model.projects[index];
                                        return ProjectCard(
                                          horizontalPadding: 0,
                                          images: item[keyPhotos] ?? [],
                                          projectImage:
                                              item[keyDeveloperImage] ??
                                                  testImage,
                                          projectName: item['title'] ?? '',
                                          projectAddress: item[keyCity] == null
                                              ? '${item[keySubCommunity] ?? ''}'
                                              : '${item[keyCity]} - ${item[keySubCommunity] ?? ''}',
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
