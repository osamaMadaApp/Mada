// ignore_for_file: must_be_immutable

import 'package:flutter_html/flutter_html.dart';

import '../../general_exports.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<ProjectDetailsModel>(
      create: (BuildContext context) => ProjectDetailsModel(),
      child: ProjectDetails(
        projectId: args?[keyProjectId],
      ),
    );
  }
}

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({
    super.key,
    this.projectId,
  });
  final dynamic projectId;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (callBack) {
        Provider.of<ProjectDetailsModel>(context, listen: false)
            .getProjectDetails(projectId: widget.projectId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.gray3),
      body: Consumer<ProjectDetailsModel>(
        builder: (BuildContext context, model, Widget? child) {
          return model.isLoading
              ? const Center()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 50.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      children: <Widget>[
                        DetailsHeader(
                          onDownloadPdfPressed: () {
                            // will modify this later when change base url
                          },
                          onSharePressed: () {
                            Share.share(
                              '${model.data[keyTitle]}\n${model.data[keyDeepLink]}',
                            );
                          },
                          onFollowPressed: () {
                            model.addToFollow(context);
                          },
                          showDownloadPdfIcon: false,
                          isFollowed: model.data[keyIsFollowed] ?? false,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Expanded(
                              flex: 5,
                              child: ProjectDetailsSection1(),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              flex: 3,
                              child: ProjectDetailsSection2(
                                statusInfoIsList: false,
                                statusInfo: model.data[keyStatusInfo] ?? [],
                                propertyType: model.data[keyPropertyCategory][0]
                                        [keyName] ??
                                    '',
                                status: model.data[keyProjectStatus] ?? '',
                                availableStatus: model.data[keyAvailableStatus],
                                statusColor: model.data[keyStatusColor],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class ProjectDetailsSection1 extends StatelessWidget {
  const ProjectDetailsSection1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectDetailsModel>(
      builder: (
        BuildContext context,
        ProjectDetailsModel model,
        Widget? child,
      ) {
        return Column(
          spacing: 20.h,
          children: [
            // Project Header
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  SliderHeader(
                    sliderImages: model.data[keyPhotos] ?? [],
                    showFollow: false,
                    threeSixtyUrl: model.data[keyUrl360],
                    onThreeSixtyPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.routeWebViewScreen,
                        arguments: {
                          keyTitle: model.data[keyTitle] ?? '',
                          keyUrl: model.data[keyUrl360] ?? '',
                        },
                      );
                    },
                    showThreeSixty: model.data[keyUrl360] != null &&
                        model.data[keyUrl360].isNotEmpty,
                    shareText: model.data[keyDeepLink],
                    shareTitle: model.data[keyTitle] ?? '',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Project Info
                  ComponentGeneralInformation(
                    name: model.data[keyTitle] ?? '',
                    priceStarts: model.data[keyStartingPrice],
                    city: model.data[keyCity] ?? '',
                    community: model.data[keySubCommunity] ?? '',
                    showPriceText: true,
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  if (model.data[keyDescription] != null &&
                      model.data[keyDescription].isNotEmpty)
                    ProjectDescription(
                      title: FFLocalizations.of(context)
                          .getText('project_description'),
                      description: model.data[keyDescription],
                      onDescriptionPressed: () {
                        model.onDescriptionPressed(context);
                      },
                    ),
                  Services(
                    services: model.data[keyAmenities] ?? [],
                    bottomPadding: DEVICE_HEIGHT * 0.02,
                  ),
                  VideoAndBrochure(
                    showBrochure: false,
                    showVideo: model.data[keyVideo] != null &&
                        model.data[keyVideo].isNotEmpty,
                    onVideoTapped: () {
                      Navigator.pushNamed(
                        context,
                        Routes.routeVideoPlayer,
                        arguments: {
                          keyUrl: model.data[keyVideo][0],
                        },
                      );
                    },
                    imageUrl: model.data[keyVideoImage],
                  ),
                  LocationAndNearbyPlaces(
                    nearbyLocations: model.data['nearestFacilityApp'] ?? [],
                    viewProjectText: FFLocalizations.of(context)
                        .getText('view_project_on_map'),
                    viewOnMap: model.onViewProjectMap,
                  ),
                  PaymentPlans(
                    paymentPlans: model.data[keyPaymentPercent],
                    percentageKey: keyPercent,
                    showAmount: false,
                    childAspectRatio: 1.4,
                    onPaymentPlanExpanded: model.onPaymentPlanExpanded,
                    isPaymentPlanExpanded: model.isPaymentPlanExpanded,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),

            // AdsSection(
            //   showAdSection: model.adBanner != null,
            //   image: model.adBanner[keyAdImage],
            //   onAdPressed: () {
            //     if (model.adBanner[keyPlatform] == keyApp) {
            //       openScreenBasedOnScreenName(
            //         model.adBanner[keyScreenNameCapital],
            //         model.adBanner[keyRecordId],
            //       );
            //     } else {
            //       Get.toNamed(
            //         routeWebViewScreen,
            //         arguments: {
            //           keyUrl:
            //               model.adBanner[keyRedirectLink] ?? ''
            //         },
            //       );
            //     }
            //   },
            // ),
          ],
        );
      },
    );
  }
}

class ProjectDetailsSection2 extends StatelessWidget {
  const ProjectDetailsSection2({
    required this.statusInfoIsList,
    super.key,
    this.status,
    this.propertyType,
    this.propertyStatus,
    this.statusInfo,
    this.availableStatus,
    this.statusColor,
  });

  final String? status;
  final String? propertyType;
  final String? propertyStatus;
  final bool statusInfoIsList;
  final List<dynamic>? statusInfo;
  final String? availableStatus;
  final String? statusColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectDetailsModel>(
      builder: (
        BuildContext context,
        ProjectDetailsModel model,
        Widget? child,
      ) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.h,
          ),
          width: 300.w,
          decoration: BoxDecoration(
            color: FlutterMadaTheme.of(context).colorFFFFFF,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            spacing: 30.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (statusInfoIsList)
                Row(
                  children: [
                    ...statusInfo!.map(
                      (label) {
                        return Row(
                          children: [
                            LabelCard(
                              text: label[keyText].toString(),
                              backgroundColor: Color(
                                int.parse(
                                  hexToColor(
                                    label[keyBackgroundColor] ?? '#FFFFFF',
                                  ),
                                ),
                              ),
                              textSize: 14,
                              textColor: Color(
                                int.parse(
                                  hexToColor(
                                    label[keyTextColor] ?? '#FFFFFF',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: DEVICE_WIDTH * 0.01,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    LabelCard(
                      text: status!,
                      showLabel: status!.isNotEmpty,
                      textSize: 14,
                    ),
                    SizedBox(
                      width: DEVICE_WIDTH * 0.01,
                    ),
                    if (propertyType != 'Land')
                      LabelCard(
                        text: propertyType!,
                        showLabel: propertyType!.isNotEmpty,
                        textSize: 14,
                      ),
                    SizedBox(
                      width: DEVICE_WIDTH * 0.01,
                    ),
                    LabelCard(
                      text: propertyStatus ?? '',
                      textSize: 14,
                      showLabel:
                          propertyStatus != null && propertyStatus!.isNotEmpty,
                      textColor: const Color(AppColors.primary),
                      backgroundColor:
                          const Color(AppColors.primary).withOpacity(0.1),
                    ),
                    LabelCard(
                      text: availableStatus ?? '',
                      textSize: 14,
                      showLabel: availableStatus != null &&
                          availableStatus!.isNotEmpty,
                      textColor:
                          (statusColor != null && statusColor!.isNotEmpty)
                              ? hexToColor2(statusColor!)
                              : Colors.transparent,
                      backgroundColor:
                          (statusColor != null && statusColor!.isNotEmpty)
                              ? hexToColor2(statusColor!).withOpacity(0.1)
                              : Colors.transparent,
                    ),
                  ],
                ),
              CompanyOrProjectSection(
                developerImage: model.data[keyDeveloperImage],
                name: model.data[keyDeveloperName],
                showRealEstateTxt: false,
              ),
              const GrayLine(),
              ProjectInformation(
                projectInfo: model.data[keyProjectInfo] ?? [],
                title: FFLocalizations.of(context).getText('project_info'),
                textKey: keyLabel,
                padding: 0,
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'project_brochure',
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        AppColors.black,
                      ),
                    ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.routeWebViewScreen,
                    arguments: {
                      keyTitle: model.data[keyTitle] ?? '',
                      keyUrl: model.data[keyAppBrochure] ?? '',
                      keyProjectBrouchure: true,
                      keySubtitle: FFLocalizations.of(context).getText(
                        'project_brochure',
                      ),
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      DEVICE_HEIGHT * 0.007,
                    ),
                    color: const Color(AppColors.gray5),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.02,
                    vertical: DEVICE_HEIGHT * 0.015,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        iconBrouchure,
                        height: DEVICE_HEIGHT * 0.02,
                        width: DEVICE_WIDTH * 0.02,
                      ),
                      SizedBox(width: DEVICE_WIDTH * 0.01),
                      MadaText(
                        FFLocalizations.of(context).getText('view_brochure'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color(
                                AppColors.black,
                              ),
                            ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(iconArrowGreen),
                    ],
                  ),
                ),
              ),
              const GrayLine(),
              ContactUsDetails(
                paddingTop: 0,
                whatsappMsg:
                    '${model.data[keyTitle] ?? ''}\n${model.data[keyPropertyCategory] ?? ''}\n${model.data[keyPrice] ?? 0} ${getCurrency()}\n${model.data[keyCity]} - ${model.data[keyCommunity]} - ${model.data[keySubCommunity] ?? ''}',
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.routeProjectUnitsListview,
                          arguments: {
                            keyProjectId: model.data[keyID],
                          },
                        );
                      },
                      text: FFLocalizations.of(context).getText('view_units'),
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(
                                  AppColors.white,
                                ),
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppColors.green3),
                        padding: EdgeInsets.symmetric(
                          vertical: DEVICE_HEIGHT * 0.019,
                          horizontal: DEVICE_WIDTH * 0.05,
                        ),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(DEVICE_WIDTH * 0.08),
                            bottomRight: Radius.circular(DEVICE_WIDTH * 0.08),
                            topLeft: Radius.circular(DEVICE_WIDTH * 0.08),
                            bottomLeft: Radius.circular(DEVICE_WIDTH * 0.08),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.04),
            ],
          ),
        );
      },
    );
  }
}

class ProjectDescription extends StatelessWidget {
  const ProjectDescription({
    required this.description,
    super.key,
    this.onDescriptionPressed,
    this.title,
  });
  final String description;
  final Function()? onDescriptionPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MadaText(
                title ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        AppColors.black,
                      ),
                    ),
              ),
              GestureDetector(
                onTap: onDescriptionPressed,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Html(
                      data: description,
                      style: {
                        'body': Style(
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize(14),
                          margin: Margins.zero,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: const Color(AppColors.gray8),
                          height: Height(DEVICE_HEIGHT * 0.08),
                        ),
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText('read_more'),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(AppColors.primary),
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(AppColors.primary),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: const GrayLine(),
        ),
      ],
    );
  }
}
