import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<HomePageModel>(
          create: (BuildContext context) => HomePageModel(),
        ),
      ],
      child: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageModel homePageModel = Provider.of<HomePageModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 50.h,
        ),
        child: homePageModel.homeData == null
            ? const Center()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderWidget(
                      profilePicture: FFAppState().userModel[keyProfilePic],
                      title: FFAppState().userModel[keyFirstName],
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
                                  menu: homePageModel.homeData[keyResults]
                                      [keyMenu],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: SliderComponent(
                            items: homePageModel.homeBanner,
                            height: 700.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    MostPopularProjects(
                      mostPopularProject: homePageModel.mostPopularProjects,
                    ),
                  ],
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
