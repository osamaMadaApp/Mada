import '../../components/unit_layout_screen/unit_layout_icon.dart';
import '../../components/unit_layout_screen/unit_layout_screen.dart';
import '../../general_exports.dart';
import 'unit_details_model.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<UnitDetailsModel>(
      create: (BuildContext context) => UnitDetailsModel(),
      child: UnitDetails(
        projectId: args?[keyID],
      ),
    );
  }
}

class UnitDetails extends StatefulWidget {
  const UnitDetails({
    super.key,
    this.projectId,
  });

  final dynamic projectId;

  @override
  State<UnitDetails> createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (callBack) {
        Provider.of<UnitDetailsModel>(context, listen: false)
            .getProjectDetails(unitId: widget.projectId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.gray3),
      body: Consumer<UnitDetailsModel>(
        builder: (BuildContext context, model, Widget? child) {
          return model.isLoading
              ? const Center()
              : Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 50.h,
                            horizontal: 20.w,
                          ),
                          child: Column(
                            children: <Widget>[
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
                                        statusInfoIsList: true,
                                        statusInfo:
                                            model.data[keyStatusInfo] ?? [],
                                        status: model.data[keyStatusInfo][0]
                                                [keyText] ??
                                            '',

                                        /// TODO CHICK WITH TEAM
                                        availableStatus:
                                            model.data[keyStatus] ?? '',
                                        statusColor:
                                            '' //model.data[keyStatusColor],
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(AppColors.gray3),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 48.h, left: 24.w, right: 24.w, bottom: 24.h),
                        child: DetailsHeader(
                          onDownloadPdfPressed: () {
                            model.createAndDownloadPdf();
                          },
                          onSharePressed: () {
                            Share.share(model.data[keyDeepLink]);
                          },
                          onFollowPressed: () {
                            model.addToFollow(context);
                          },
                          isFollowed: model.data[keyIsFollowed] ?? false,
                        ),
                      ),
                    ),
                  ],
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
    return Consumer<UnitDetailsModel>(
      builder: (
        BuildContext context,
        UnitDetailsModel model,
        Widget? child,
      ) {
        return Column(
          spacing: 20.h,
          children: [
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
                    sliderImages: model.data[keyImage] ?? [],
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
                  ComponentGeneralInformation(
                    name:
                        '${model.data[keyTitle] ?? ''} - ${model.data[keyUnitNumber] ?? ''}',
                    priceStarts: model.data[keyCost] ?? '',
                    city: model.data[keyCity] ?? '',
                    community: model.data[keySubCommunity] ?? '',
                    priceText:
                        FFLocalizations.of(context).getText('price_with_tax'),
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
                  if (model.data[keyGeneralDetails] != null &&
                      model.data[keyGeneralDetails].isNotEmpty)
                    ProjectDescription(
                      title: FFLocalizations.of(context)
                          .getText('general_details'),
                      projectInfo: model.data[keyGeneralDetails],
                      onDescriptionPressed: () {
                        model.onDescriptionPressed(context);
                      },
                    ),
                  UnitLayoutIcon(
                    planImage: model.data[keyPlan][0],
                    onTap: () {
                      SideSheet.show(
                        context,
                        child: UnitLayoutScreen(
                          unitNumber: model.data[keyUnitNumber],
                          onClose: () {
                            Navigator.pop(context);
                          },
                          title: model.data[keyProjectTitle],
                          image: model.data[keyPlan][0],
                        ),
                        title: '${FFLocalizations.of(context).getText('layout_of_unit_no')} ${model.data[keyUnitNumber]}',
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: GrayLine()),
                  Services(
                    services: model.data[keyAmenitiesData] ?? [],
                    bottomPadding: DEVICE_HEIGHT * 0.02,
                  ),
                  if (model.data[keyNearbyFacilities] != null &&
                      model.data[keyNearbyFacilities].isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProjectInformation(
                            projectInfo: model.data[keyNearbyFacilities] ?? [],
                            title: FFLocalizations.of(context)
                                .getText('location_nearby_places'),
                            textKey: keyName,
                            valueKey: keyDistance,
                            padding: 0,
                          ),
                        ],
                      ),
                    ),
                  PaymentPlans(
                    paymentPlans: model.data[keyPaymentPlans],
                    percentageKey: keyPercent,
                    showAmount: false,
                    showGrayLine: false,
                    childAspectRatio: 1.4,
                    onPaymentPlanExpanded: model.onPaymentPlanExpanded,
                    isPaymentPlanExpanded: model.isPaymentPlanExpanded,
                  ),
                  LocationAndNearbyPlaces(
                    title: FFLocalizations.of(context)
                        .getText('live_location_on_map'),
                    nearbyLocations: model.data['nearestFacilityApp'] ?? [],
                    viewProjectText: FFLocalizations.of(context)
                        .getText('view_project_on_map'),
                    viewOnMap: model.onViewProjectMap,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
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
    return Consumer<UnitDetailsModel>(
      builder: (
        BuildContext context,
        UnitDetailsModel model,
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
                name: model.data[keyTitle],
                companyName: model.data[keyDeveloperName],
              ),
              const GrayLine(),
              ProjectInformation(
                projectInfo: model.data[keyFinancialDetails] ?? [],
                title: FFLocalizations.of(context).getText('financial_details'),
                textKey: keyLabel,
                padding: 0,
              ),
              SizedBox(
                height: 136.h,
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
                          Routes.routePayment,
                          arguments: {
                            keyPropertyId: model.data[keyID],
                          },
                        );
                      },
                      text: FFLocalizations.of(context).getText('book_now'),
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
    required this.projectInfo,
    super.key,
    this.onDescriptionPressed,
    this.title,
  });

  final List<dynamic> projectInfo;
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
              ProjectInformation(
                projectInfo: projectInfo ?? [],
                title: title,
                textKey: keyLabel,
                padding: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
