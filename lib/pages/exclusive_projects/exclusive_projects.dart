import '../../components/labeled_icon_card_gradient_color/labeled_icon_card_gradient_color.dart';
import '../../components/mada_header/mada_header.dart';
import '../../components/property_card/PropertyCard.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import 'package:flutter/material.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import '../../structure_main_flow/internationalization.dart';
import '../../structure_main_flow/nav/serialization_util.dart';
import 'exclusive_projects_model.dart';

class ExclusiveProjects extends StatelessWidget {
  const ExclusiveProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExclusiveProjectsModel(),
      child:  _ExclusiveProjectsWidgetState(),
    );
  }
}
class _ExclusiveProjectsWidgetState extends StatelessWidget{
   final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
   return Consumer<ExclusiveProjectsModel>(
      builder: (BuildContext context, _model, Widget? child) {
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
                                  padding: EdgeInsets.fromLTRB(
                                      24.w, 32.h, 24.w, 0.h),
                                  child: Text(
                                    FFLocalizations.of(context)
                                        .getText('projects_categories'),
                                    style: TextStyle(
                                      color: FlutterMadaTheme.of(context)
                                          .color000000,
                                      fontSize: 18.0,
                                      fontFamily: AppFonts.outfit,
                                      fontWeight: AppFonts.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 16.h),
                              child: SizedBox(
                                height: 96.h,
                                // Set an appropriate height for horizontal scrolling
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _model.menu.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 0.h, 0.w, 0.h),
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
                                          color:
                                          FlutterMadaTheme.of(context)
                                              .color000000,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                          fontFamily: AppFonts.workSans,
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Routes.routeProjectsListview,
                                              arguments: {
                                                keyType: serializeParam(
                                                  _model.menu[index][keyName],
                                                  ParamType.String,
                                                ),
                                                keyProjectStatus:
                                                serializeParam(
                                                  _model.menu[index]
                                                  [keyValue],
                                                  ParamType.String,
                                                ),
                                                keyTitle: serializeParam(
                                                  _model.menu[index]
                                                  [keyName] ??
                                                      '',
                                                  ParamType.String,
                                                ),
                                              });
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
                                return PropertyCard(item: item);
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
      },
    );
  }
}
