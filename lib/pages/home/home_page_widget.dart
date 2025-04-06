import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageModel(() {
        showLogoutDialog(context);
      }),
      child: const Home(),
    );
  }

  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context, // Ensure context is provided
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: MadaText(
            FFLocalizations.of(dialogContext).getVariableText(
              enText: 'Session Ended',
              arText: 'انتهت الجلسة',
            ),
            style: Theme.of(dialogContext).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: FlutterMadaTheme.of(dialogContext).color000000,
                ),
          ),
          content: MadaText(
            FFLocalizations.of(dialogContext).getVariableText(
              enText:
                  'Your session has ended for a security reason. Please re-login.',
              arText: 'انتهت جلستك لسبب امني. يرجى تسجيل الدخول مرة أخرى.',
            ),
            style: Theme.of(dialogContext).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: FlutterMadaTheme.of(dialogContext).color000000,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog properly
              },
              child: MadaText(
                FFLocalizations.of(dialogContext).getVariableText(
                  enText: 'Log Out',
                  arText: 'تسجيل خروج',
                ),
                style: Theme.of(dialogContext).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: FlutterMadaTheme.of(dialogContext).color000000,
                    ),
              ),
            ),
          ],
        );
      },
    ).then((onValue) {
      if (context.mounted) {
        FFAppState().clearUserData();
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.routeLogin,
          (Route<dynamic> route) => false,
        );
      }
    });
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Consumer<HomePageModel>(
            builder: (BuildContext context, homePageModel, Widget? child) {
              return homePageModel.homeData == null
                  ? const Center()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HeaderWidget(
                            profilePicture:
                                FFAppState().userModel[keyProfilePic],
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
                                  color:
                                      FlutterMadaTheme.of(context).colorF5F5F5,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              color:
                                                  FlutterMadaTheme.of(context)
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
                                              color:
                                                  FlutterMadaTheme.of(context)
                                                      .color292D32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(height: 20.h),
                                      HomeCategories(
                                        menu: context
                                            .watch<HomePageModel>()
                                            .homeData[keyResults][keyMenu],
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
                            mostPopularProject: context
                                .watch<HomePageModel>()
                                .mostPopularProjects,
                          ),
                        ],
                      ),
                    );
            },
          )),
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
        ...menu.take(2).map((dynamic item) {
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
                switch (menu[index][keyLink]) {
                  case 'projects/exclusive-projects':
                    Navigator.pushNamed(context, Routes.routeExclusiveProjects);
                  case 'propeties/list':
                    Navigator.pushNamed(context, Routes.routeSearchScreen);
                  case 'request-property':
                  case 'user/properties/list-property':
                  default:
                    null;
                }
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
                        Navigator.pushNamed(
                          context,
                          Routes.routeProjectDetails,
                          arguments: {
                            keyProjectId: mostPopularProject[index][keySlug],
                          },
                        );
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
