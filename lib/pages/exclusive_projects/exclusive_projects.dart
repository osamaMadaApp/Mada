import '../../components/labeled_icon_card_gradient_color/labeled_icon_card_gradient_color.dart';
import '../../components/mada_header/mada_header.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../structure_main_flow/internationalization.dart';
import 'exclusive_projects_model.dart';

class ExclusiveProjects extends StatefulWidget {
  const ExclusiveProjects({super.key});

  @override
  State<ExclusiveProjects> createState() => _ExclusiveProjectsWidgetState();
}

class _ExclusiveProjectsWidgetState extends State<ExclusiveProjects>
    with TickerProviderStateMixin {
  late ExclusiveProjectsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<ExclusiveProjectsModel>();
    _model.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    _model = context.watch<ExclusiveProjectsModel>();
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: MadaHeader(
              title: FFLocalizations.of(context).getText('exclusive_projects')),
          key: scaffoldKey,
          // backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            onRefresh: _model.onRefresh,
            color: FlutterMadaTheme.of(context).primary,
            child: _model.isLoading
                ? const Center()
                : SingleChildScrollView(
                    controller: _model.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: FlutterMadaTheme.of(context).colorFFFFFF,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 0.h),
                                    child: Text(
                                      FFLocalizations.of(context)
                                          .getText('projects_categories'),
                                      style: TextStyle(
                                        color: FlutterMadaTheme.of(context).color000000,
                                        fontSize: 18.0,
                                        fontFamily: AppFonts.outfit,
                                        fontWeight: AppFonts.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 16.h),
                                child: SizedBox(
                                  height: 96.h,
                                  // Set an appropriate height for horizontal scrolling
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _model.menu.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(16.w, 0.h, 0.w, 0.h),
                                        // Add some spacing between items
                                        child: LabeledIconCardGradientColor(
                                          columnCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          title: _model.menu[index][keyName],
                                          icon: _model.menu[index][keyImage],
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            color: FlutterMadaTheme.of(context)
                                                .color000000,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                            fontFamily: AppFonts.workSans,
                                          ),
                                          onTap: () {
                                            // Navigation or action logic
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.02,
                            vertical: DEVICE_HEIGHT * 0.02,
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
                                    '${FFLocalizations.of(context).getText('result')} ${_model.menu.length} ${FFLocalizations.of(context).getText('project')}',
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
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 434,
                                  mainAxisSpacing: DEVICE_HEIGHT * 0.0090,
                                  crossAxisSpacing: DEVICE_WIDTH * 0.0009,
                                  childAspectRatio: 434 / 231,
                                ),
                                itemCount: _model.lastProjects.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = _model.lastProjects[index];
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.w, 3.h, 8.w, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                                child: SliderComponent(
                                                  items: item[keyPhotos] ??
                                                      [] ??
                                                      <dynamic>[],
                                                  height: 150.h,
                                                  showIndicator: false,
                                                  fit: BoxFit.cover,
                                                  topGradient: false,
                                                  bottomLeftRadius: 0,
                                                  bottomRightRadius: 0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Visibility(
                                                    visible:
                                                        item?[keyProjectType] !=
                                                            null,
                                                    child: LabelCard(
                                                        paddingVertical: 4.w,
                                                        paddingHorizontal: 8.w,
                                                        text: item?[
                                                                keyProjectType] ??
                                                            ''),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8.w, 0, 8.w, 0),
                                                    child: LabelCard(
                                                      paddingVertical: 4.w,
                                                      paddingHorizontal: 8.w,
                                                      text:
                                                          '${FFLocalizations.of(context).getText('available')} ${item[keyTotalAvailableUnits] ?? ''} ${FFLocalizations.of(context).getText('of')} ${item[keyTotalUnits] ?? ''}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.w, 16.h, 8.w, 16.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CachedImage(
                                                image:
                                                    item?[keyDeveloperImage] ??
                                                        testImage,
                                                width: 41.w,
                                                height: 41.w,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.w, 0, 8.w, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        item[keyTitle] ?? '',
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  color: FlutterMadaTheme.of(
                                                                          context)
                                                                      .color000000,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      AppFonts
                                                                          .outfit,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                      ),
                                                      SizedBox(height: 8.h),
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    6.w, 0),
                                                            child: SvgPicture
                                                                .asset(
                                                                    iconLocation),
                                                          ),
                                                          Text(
                                                            '${item[keyCity]} - ${item[keySubCommunity] ?? ''}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  color: FlutterMadaTheme.of(
                                                                          context)
                                                                      .color989898,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      AppFonts
                                                                          .outfit,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 5,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    int.parse(
                                                      hexToColor(
                                                        item?[keyGetAvailableStatusLable]
                                                                ?[
                                                                keyColorCode] ??
                                                            '#FFFFFF',
                                                      ),
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(16),
                                                  ),
                                                ),
                                                child: Text(
                                                  item?[keyGetAvailableStatusLable]
                                                          ?[keyValue] ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color:
                                                            FlutterMadaTheme.of(
                                                                    context)
                                                                .colorFFFFFF,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
