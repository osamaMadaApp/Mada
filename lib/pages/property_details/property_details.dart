import '../../general_exports.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<PropertyDetailsModel>(
      create: (BuildContext context) => PropertyDetailsModel(),
      child: PropertyDetails(
        propertyId: args?[keyPropertyId],
      ),
    );
  }
}

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({
    super.key,
    this.propertyId,
  });

  final dynamic propertyId;

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (callBack) {
        Provider.of<PropertyDetailsModel>(context, listen: false)
            .getPropertyDetails(propertyId: widget.propertyId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.gray3),
      body: Consumer<PropertyDetailsModel>(
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
                            model.createAndDownloadPdf();
                          },
                          onSharePressed: () {
                            Share.share(
                              '${model.data[keyTitle]}\n${model.data[keyDeepLink]}',
                            );
                          },
                          showFollow: false,
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
                              child: PropertyDetailsSection1(),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              flex: 3,
                              child: PropertyDetailsSection2(
                                statusInfoIsList: true,
                                statusInfo: model.data[keyStatusInfo] ?? [],
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

class PropertyDetailsSection1 extends StatelessWidget {
  const PropertyDetailsSection1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyDetailsModel>(
      builder: (
        BuildContext context,
        PropertyDetailsModel model,
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
                    priceStarts: model.data[keyPrice],
                    city: model.data[keyCity] ?? '',
                    community: model.data[keySubCommunity] ?? '',
                    showPriceText: true,
                  ),
                ],
              ),
            ),
            // if (model.data[keyDescription] != null &&
            //     model.data[keyDescription].isNotEmpty)
            //   PropertyDescription(
            //     description: model.data[keyDescription],
            //     onDescriptionPressed: model.onDescriptionPressed,
            //   ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  ProjectInformation(
                    projectInfo: model.data[keyPropertyInfo] ?? [],
                    title: FFLocalizations.of(context).getText('property_info'),
                    textKey: keyLabel,
                  ),
                  Services(
                    services: model.data[keyAmenities] ?? [],
                    bottomPadding: DEVICE_HEIGHT * 0.02,
                  ),
                  VideoAndBrochure(
                    showBrochure: model.data[keyAppBrochure] != null,
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
                    imageUrl: model.data[keyVideoImage] ?? testImage,
                    onViewBrochure: () {
                      Navigator.pushNamed(
                        context,
                        Routes.routeWebViewScreen,
                        arguments: {
                          keyTitle: model.data[keyTitle] ?? '',
                          keyUrl: model.data[keyAppBrochure] ?? '',
                          keyProjectBrouchure: true,
                          keySubtitle: FFLocalizations.of(context).getText(
                            'property_brochure',
                          ),
                        },
                      );
                    },
                  ),
                  LocationAndNearbyPlaces(
                    nearbyLocations: model.data['nearestFacilityApp'] ?? [],
                    viewProjectText: FFLocalizations.of(context)
                        .getText('view_property_on_map'),
                    viewOnMap: model.onViewPropertyMap,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class PropertyDetailsSection2 extends StatelessWidget {
  const PropertyDetailsSection2({
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
    return Consumer<PropertyDetailsModel>(
      builder: (
        BuildContext context,
        PropertyDetailsModel model,
        Widget? child,
      ) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          width: 300.w,
          decoration: BoxDecoration(
            color: FlutterMadaTheme.of(context).colorFFFFFF,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            spacing: 20.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
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
              const GrayLine(),
              // Mortgage Calculator
              if (model.data[keyIsMortgageAvailable] != null &&
                  model.data[keyIsMortgageAvailable] == true)
                Column(
                  children: [
                    CalculatorProperty(
                      propertyAmountDetail: model.data[keyPropertyAmountDetail],
                      propertyPrice: model.data[keyPrice] != null
                          ? model.data[keyPrice].toDouble()
                          : 0,
                      showLine: false,
                      monthlyPayment: model.getMonthlyPayment(),
                    ),
                  ],
                ),
              // Rega Info
              RegulatoryInformation(
                regularlyInfo: model.data[keyRegaInfo][keyVerifedInfo] ?? [],
                locations: model.data[keyRegaInfo][keyLocationInfo] ?? [],
                propertySpec:
                    model.data[keyRegaInfo][keyPropertySpecsInfo] ?? [],
                regaInfo: model.data[keyRegaInfo],
              ),
              // REGA QR CODE
              if (model.data[keyRegaInfo][keyQrUrl] != null &&
                  model.data[keyRegaInfo][keyQrUrl].isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MadaText(
                      FFLocalizations.of(context)
                          .getText('view_details_on_rega'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color(
                              AppColors.black,
                            ),
                          ),
                    ),
                    SizedBox(
                      height: DEVICE_HEIGHT * 0.015,
                    ),
                    SizedBox(
                      width: DEVICE_WIDTH,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: DEVICE_HEIGHT * 0.005,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                launchWeb(
                                  context,
                                  model.data[keyRegaInfo][keyQrUrl] ?? '',
                                );
                              },
                              child: QrImageView(
                                data: model.data[keyRegaInfo][keyQrUrl] ?? '',
                                size: DEVICE_HEIGHT * 0.17,
                                gapless: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DEVICE_HEIGHT * 0.02,
                    ),
                  ],
                ),

              // Agent Details
              Agent(
                agentInfo: model.data[keyAgent],
              ),
              ContactUsDetails(
                paddingTop: 0,
                phoneNumber: model.data[keyPhoneNumber],
                whatsapp: model.data[keyWhatsappNumber],
                showWhatsapp: model.data[keyWhatsappNumber] != null,
                whatsappMsg:
                    '${model.data[keyTitle] ?? ''}\n${model.data[keyPropertyCategory] ?? ''}\n${model.data[keyPrice] ?? 0} ${getCurrency()}\n${model.data[keyCity]} - ${model.data[keyCommunity]} - ${model.data[keySubCommunity] ?? ''}',
              ),
              if (model.data[keyCanOwn] != null && model.data[keyCanOwn])
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          model.onOwnProperty(
                            onContactPopUp: () {
                              SideSheet.show(
                                context,
                                child: ContactTeamSheet(
                                  whatsappMsg:
                                      '${model.data[keyTitle] ?? ''}\n${model.data[keyPropertyCategory] ?? ''}\n${model.data[keyPrice] ?? 0} ${getCurrency()}\n${model.data[keyCity] ?? ''} - ${model.data[keyCommunity] ?? ''} - ${model.data[keySubCommunity] ?? ''}',
                                ),
                                title: FFLocalizations.of(context)
                                    .getText('confirm_your_data'),
                              );
                            },
                            onNafathVerificationSheet: () {
                              SideSheet.show(
                                context,
                                child: const ConfirmNafathSheet(),
                                title: FFLocalizations.of(context).getText(
                                  'confirm_your_data',
                                ),
                              );
                            },
                            onPayment: () {
                              Navigator.pushNamed(
                                context,
                                Routes.routePayment,
                                arguments: {
                                  keyPropertyId: model.data[keyID],
                                },
                              );
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
                            horizontal: DEVICE_WIDTH * 0.1,
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
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        SideSheet.show(
                          context,
                          child: ReportPropertySheet(
                            onSendReport: (reasonId, userType, otherDetails) {
                              model.onSendReport(
                                reasonId,
                                userType,
                                otherDetails,
                                () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                          title: FFLocalizations.of(context)
                              .getText('report_this_property'),
                        );
                      },
                      text: FFLocalizations.of(context)
                          .getText('report_this_property'),
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(
                                  AppColors.black,
                                ),
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(AppColors.green3).withOpacity(
                          0.1,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: DEVICE_HEIGHT * 0.019,
                          horizontal: DEVICE_WIDTH * 0.1,
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
              SizedBox(
                height: DEVICE_HEIGHT * 0.04,
              ),
            ],
          ),
        );
      },
    );
  }
}
