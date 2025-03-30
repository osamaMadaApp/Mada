import '../../general_exports.dart';

class ProjectUnitsListviewScreen extends StatelessWidget {
  const ProjectUnitsListviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<ProjectUnitsListviewModel>(
      create: (BuildContext context) => ProjectUnitsListviewModel(),
      child: ProjectUnitsListview(
        projectId: args?[keyProjectId],
      ),
    );
  }
}

class ProjectUnitsListview extends StatefulWidget {
  const ProjectUnitsListview({
    super.key,
    this.projectId,
  });

  final dynamic projectId;

  @override
  State<ProjectUnitsListview> createState() =>
      _ProjectUnitsListviewWidgetState();
}

class _ProjectUnitsListviewWidgetState extends State<ProjectUnitsListview> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ProjectUnitsListviewModel>(context, listen: false)
          .initState(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectUnitsListviewModel>(
      builder: (
        BuildContext context,
        ProjectUnitsListviewModel model,
        Widget? child,
      ) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: MadaHeader(
              title: FFLocalizations.of(context).getText('project_units'),
              actions: [
                // GestureDetector(
                //   onTap: () {
                //     model.onSortPressed(context);
                //   },
                //   child: Container(
                //     padding: EdgeInsets.all(DEVICE_WIDTH * 0.01),
                //     margin: EdgeInsets.symmetric(
                //       horizontal: DEVICE_WIDTH * 0.02,
                //     ),
                //     decoration: BoxDecoration(
                //       color: const Color(AppColors.green3).withOpacity(0.1),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: SvgPicture.asset(
                //       iconSort,
                //       colorFilter: const ColorFilter.mode(
                //         Colors.black,
                //         BlendMode.srcIn,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            key: scaffoldKey,
            // backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: model.onRefresh,
              color: FlutterMadaTheme.of(context).primary,
              child: model.data == null
                  ? const Center()
                  : Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              RefreshIndicator(
                                onRefresh: model.onRefresh,
                                color: FlutterMadaTheme.of(context).primary,
                                backgroundColor: Colors.white,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: model.scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: DEVICE_WIDTH * 0.02,
                                          vertical: DEVICE_HEIGHT * 0.02,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${FFLocalizations.of(context).getText('available_units')} ( ${model.data[keyResults][keyFinalData][keyTotalDocs] ?? 0} )',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                            SizedBox(
                                                height: DEVICE_HEIGHT * 0.02),
                                            Column(
                                              children: [
                                                if (model.unitsResult.isEmpty &&
                                                    !model.isLoading)
                                                  SizedBox(
                                                    height: DEVICE_HEIGHT * 0.6,
                                                    child: Center(
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'no_data_found',
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          isPortrait(context)
                                                              ? 2
                                                              : 3,
                                                      mainAxisExtent:
                                                          isPortrait(context)
                                                              ? 260
                                                              : 230,
                                                    ),
                                                    itemCount: model
                                                        .unitsResult.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final unit = model
                                                          .unitsResult[index];

                                                      return ProjectUnitCard(
                                                        item: unit,
                                                        showUnitNumber: true,
                                                        maxLines: 3,
                                                        showBathroom:
                                                            unit[keyUnitType] !=
                                                                'Land',
                                                        showBedroom:
                                                            unit[keyUnitType] !=
                                                                'Land',
                                                        onFavoritesPressed: () {
                                                          model.favorites(
                                                            unit,
                                                            context,
                                                          );
                                                        },
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                            context,
                                                            Routes
                                                                .routeUnitDetails,
                                                            arguments: {
                                                              keyID:
                                                                  unit[keyID],
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
