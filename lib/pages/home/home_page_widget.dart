import 'package:flutter/scheduler.dart';

import '/structure_main_flow/flutter_mada_util.dart';
import '../../components/header_widget/header_widget.dart';
import '../../general_exports.dart';
import '../../index.dart';
import 'home_page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePage>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        ApiRequest(
          path: apiHomeScreen,
          formatResponse: true,
          className: 'HomeController/getHomeScreenResult',
        ).request(
          onSuccess: (dynamic data, dynamic response) {
            _model.homeData = data;
            for (dynamic image in _model.homeData[keyResults][keyHomeBanner]) {
              _model.homeBanner.add(image[keyBannerImage]);
            }
            _model.mostPopularProjects =
                _model.homeData[keyResults][keyMostPopularProject];
            setState(() {});
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: wrapWithModel(
        model: _model,
        updateCallback: () => setState(() {}),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 50.h,
          ),
          child: _model.homeData == null
              ? const Center()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HeaderWidget(
                        profilePicture: FFAppState().userModel[keyProfilePic],
                        firstName: FFAppState().userModel[keyFirstName],
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 700.h,
                            constraints: BoxConstraints(
                              maxWidth: 330.w,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterMadaTheme.of(context).colorF5F5F5,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(imageGrayLogo),
                                  SizedBox(height: 20.h),
                                  MadaText(
                                    FFLocalizations.of(context).getText(
                                      'your_gateway_to_premium_life',
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: FlutterMadaTheme.of(context)
                                              .color292D32,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                  ),
                                  SizedBox(height: 40.h),
                                  MadaText(
                                    FFLocalizations.of(context).getText(
                                      'browse_out_main_categories',
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: FlutterMadaTheme.of(context)
                                              .color292D32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(height: 20.h),
                                  HomeCategories(
                                    menu: _model.homeData[keyResults][keyMenu],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: SliderComponent(
                              items: _model.homeBanner,
                              height: 700.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      MostPopularProjects(
                        mostPopularProject: _model.mostPopularProjects,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class HomeCategories extends StatelessWidget {
  const HomeCategories({required this.menu, super.key});

  final List<dynamic> menu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...menu.map((dynamic item) {
          final int index = menu.indexOf(item);
          return Padding(
            padding: EdgeInsets.only(bottom: 19.h),
            child: LabeledIconCard(
              minWidth: 300.w,
              icon:
                  menu[index][keyImage] == null || menu[index][keyImage].isEmpty
                      ? imageExclusive
                      : menu[index][keyImage],
              title: menu[index][keyName],
              mainAxisAlignment: MainAxisAlignment.center,
              onTap: () {
                // switch (menu[index][keyLink]) {
                //   case 'projects/exclusive-projects':
                //     Get.toNamed(routeExclusiveProjects);
                //   case 'propeties/list':
                //     Get.toNamed(routeSearchScreen);
                //   case 'request-property':
                //     Get.toNamed(routeRequestYourProperty);
                //   case 'user/properties/list-property':
                //     Get.toNamed(routeListProperty);
                //   default:
                //     null;
                // }
              },
            ),
          );
        })
      ],
    );
  }
}

class MostPopularProjects extends StatelessWidget {
  const MostPopularProjects({
    required this.mostPopularProject,
    super.key,
  });

  final List<dynamic> mostPopularProject;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MadaText(
              FFLocalizations.of(context).getText(
                'most_popular_projects',
              ),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: FlutterMadaTheme.of(context).color000000,
                  ),
            ),
            SizedBox(height: 8.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  ...mostPopularProject.map((dynamic item) {
                    final int index = mostPopularProject.indexOf(item);
                    return ProjectCard(
                      horizontalPadding: 0,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      images:
                          mostPopularProject[index][keyPhotos] ?? <dynamic>[],
                      projectImage: mostPopularProject[index]
                              [keyDeveloperImage] ??
                          testImage,
                      projectName: mostPopularProject[index][keyTitle] ?? '',
                      projectAddress: mostPopularProject[index][keyCity] +
                          '-' +
                          '${mostPopularProject[index][keySubCommunity] ?? ''}',
                      statusText: mostPopularProject[index][keyStatus] ?? '',
                      totalUnits:
                          mostPopularProject[index][keyTotalUnits] ?? '',
                      availableUnits: mostPopularProject[index]
                              [keyTotalAvailableUnits] ??
                          '',
                      projectStatus: mostPopularProject[index]
                          [keyProjectStatus],
                      getAvailableStatusLable: mostPopularProject[index]
                          [keyGetAvailableStatusLable],
                      projectCategory: mostPopularProject[index]
                          [keyProjectType],
                      onTap: () {
                        // Get.toNamed(
                        //   routeProjectDetails,
                        //   arguments: mostPopularProject[index][keySlug],
                        // );
                      },
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
