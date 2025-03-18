// ignore_for_file: must_be_immutable

// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:qr_flutter/qr_flutter.dart';

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
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 50.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    children: <Widget>[
                      DetailsHeader(
                        onDownloadPdfPressed: () {},
                        onSharePressed: () {},
                        title: model.data[keyTitle] ?? '',
                        showFollow: false,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
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
        return SingleChildScrollView(
          child: Column(
            children: [
              // Project Header
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SliderHeader(
                      sliderImages: model.data[keyPhotos] ?? [],
                      showFollow: false,
                      threeSixtyUrl: model.data[keyUrl360],
                      onThreeSixtyPressed: model.threeSixtyUrlPressed,
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
                    const GrayLine(),
                  ],
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              // if (model.data[keyDescription] != null &&
              //     model.data[keyDescription].isNotEmpty)
              //   PropertyDescription(
              //     description: model.data[keyDescription],
              //     onDescriptionPressed: model.onDescriptionPressed,
              //   ),
              // ProjectInformation(
              //   projectInfo: model.data[keyPropertyInfo] ?? [],
              //   title: 'property_info'.tr,
              //   textKey: keyLabel,
              // ),
              // SizedBox(
              //   height: DEVICE_HEIGHT * 0.02,
              // ),
              // Services(
              //   services: model.data[keyAmenities] ?? [],
              //   onShowAllServicesTap: model.onShowAllServicesTap,
              //   showLine: false,
              //   bottomPadding: DEVICE_HEIGHT * 0.02,
              // ),
              // VideoAndBrochure(
              //   showBrochure: model.data[keyAppBrochure] != null,
              //   showVideo: model.data[keyVideo] != null &&
              //       model.data[keyVideo].isNotEmpty,
              //   onVideoTapped: model.onVideoTapped,
              //   imageUrl: model.data[keyVideoImage] ?? testImage,
              //   onViewBrochure: model.onViewBrochure,
              //   showBottomGrayLine: true,
              //   showUpperGrayLine: true,
              // ),
              // if (model.data[keyAppBrochure] == null &&
              //     (model.data[keyVideo] == null ||
              //         model.data[keyVideo].isEmpty))
              //   const GrayLine(),
              // LocationAndNearbyPlaces(
              //   nearbyLocations:
              //       model.data[keyNearbyFacilities] ?? [],
              //   viewProjectText: 'view_property_on_map'.tr,
              //   viewOnMap: model.onViewPropertyMap,
              // ),
              // if (model.data[keyIsMortgageAvailable] != null &&
              //     model.data[keyIsMortgageAvailable] == true)
              //   Column(
              //     children: [
              //       const GrayLine(),
              //       Padding(
              //         padding: EdgeInsets.only(
              //           top: DEVICE_HEIGHT * 0.02,
              //         ),
              //         child: CalculatorProperty(
              //           propertyAmountDetail:
              //               model.data[keyPropertyAmountDetail],
              //           propertyPrice: model.data[keyPrice] != null
              //               ? model.data[keyPrice].toDouble()
              //               : 0,
              //           showLine: false,
              //           monthlyPayment: model.getMonthlyPayment(),
              //         ),
              //       ),
              //     ],
              //   ),
              // Agent(
              //   agentInfo: model.data[keyAgent],
              // ),
              // const GrayLine(),
              // SizedBox(height: DEVICE_HEIGHT * 0.02),
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
              // RegulatoryInformation(
              //   regularlyInfo:
              //       model.data[keyRegaInfo][keyVerifedInfo] ?? [],
              //   locations:
              //       model.data[keyRegaInfo][keyLocationInfo] ?? [],
              //   propertySpec: model.data[keyRegaInfo]
              //           [keyPropertySpecsInfo] ??
              //       [],
              //   regaInfo: model.data[keyRegaInfo],
              // ),
              // // REGA QR CODE
              // if (model.data[keyRegaInfo][keyQrUrl] != null &&
              //     model.data[keyRegaInfo][keyQrUrl].isNotEmpty)
              //   Padding(
              //     padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: [
              //         MadaText(
              //           'view_details_on_rega'.tr,
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyMedium!
              //               .copyWith(
              //                 fontWeight: FontWeight.w500,
              //                 color: const Color(
              //                   AppColors.black,
              //                 ),
              //               ),
              //         ),
              //         SizedBox(
              //           height: DEVICE_HEIGHT * 0.015,
              //         ),
              //         SizedBox(
              //           width: DEVICE_WIDTH,
              //           child: Align(
              //             alignment: isRTL
              //                 ? Alignment.centerRight
              //                 : Alignment.centerLeft,
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(
              //                 horizontal: DEVICE_HEIGHT * 0.005,
              //               ),
              //               child: QrImageView(
              //                 data: model.data[keyRegaInfo]
              //                         [keyQrUrl] ??
              //                     '',
              //                 size: DEVICE_HEIGHT * 0.17,
              //                 gapless: false,
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: DEVICE_HEIGHT * 0.02,
              //         ),
              //       ],
              //     ),
              //   ),

              // ContactUsDetails(
              //   paddingTop: 0.0,
              //   phoneNumber: model.data[keyPhoneNumber],
              //   whatsapp: model.data[keyWhatsappNumber],
              //   showWhatsapp:
              //       model.data[keyWhatsappNumber] != null,
              //   whatsappMsg:
              //       '${model.data[keyTitle] ?? ''}\n${model.data[keyPropertyCategory] ?? ''}\n${model.data[keyPrice] ?? 0} ${getCurrency()}\n${model.data[keyCity]} - ${model.data[keyCommunity]} - ${model.data[keySubCommunity] ?? ''}',
              // ),
              // if (model.data[keyCanOwn] != null &&
              //     model.data[keyCanOwn])
              //   Padding(
              //     padding: EdgeInsets.only(
              //       left: DEVICE_WIDTH * 0.04,
              //       right: DEVICE_WIDTH * 0.04,
              //       bottom: DEVICE_HEIGHT * 0.015,
              //     ),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: CustomButton(
              //             onPressed: model.onOwnProperty,
              //             text: 'own_now'.tr,
              //             textStyle: Theme.of(context)
              //                 .textTheme
              //                 .bodySmall!
              //                 .copyWith(
              //                   fontWeight: FontWeight.w600,
              //                   color: const Color(
              //                     AppColors.white,
              //                   ),
              //                 ),
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor:
              //                   const Color(AppColors.green3),
              //               padding: EdgeInsets.symmetric(
              //                 vertical: DEVICE_HEIGHT * 0.019,
              //                 horizontal: DEVICE_WIDTH * 0.1,
              //               ),
              //               shadowColor: Colors.transparent,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(
              //                       DEVICE_WIDTH * 0.08),
              //                   bottomRight: Radius.circular(
              //                       DEVICE_WIDTH * 0.08),
              //                   topLeft: Radius.circular(
              //                       DEVICE_WIDTH * 0.08),
              //                   bottomLeft: Radius.circular(
              //                       DEVICE_WIDTH * 0.08),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),

              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: DEVICE_WIDTH * 0.04,
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: CustomButton(
              //           onPressed: model.reportProperty,
              //           text: 'report_this_unit'.tr,
              //           textStyle: Theme.of(context)
              //               .textTheme
              //               .bodySmall!
              //               .copyWith(
              //                 fontWeight: FontWeight.w600,
              //                 color: const Color(
              //                   AppColors.black,
              //                 ),
              //               ),
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor:
              //                 const Color(AppColors.green3).withOpacity(
              //               0.1,
              //             ),
              //             padding: EdgeInsets.symmetric(
              //               vertical: DEVICE_HEIGHT * 0.019,
              //               horizontal: DEVICE_WIDTH * 0.1,
              //             ),
              //             shadowColor: Colors.transparent,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.only(
              //                 topRight:
              //                     Radius.circular(DEVICE_WIDTH * 0.08),
              //                 bottomRight:
              //                     Radius.circular(DEVICE_WIDTH * 0.08),
              //                 topLeft:
              //                     Radius.circular(DEVICE_WIDTH * 0.08),
              //                 bottomLeft:
              //                     Radius.circular(DEVICE_WIDTH * 0.08),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: DEVICE_HEIGHT * 0.04,
              // ),
            ],
          ),
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
      builder:
          (BuildContext context, PropertyDetailsModel model, Widget? child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          width: 300.w,
          height: MediaQuery.of(context).size.height - 450.h,
          decoration: BoxDecoration(
            color: FlutterMadaTheme.of(context).colorFFFFFF,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            spacing: 20.h,
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
              const GrayLine(),
              // if (model.data[keyIsMortgageAvailable] != null &&
              //     model.data[keyIsMortgageAvailable] == true)
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
                Padding(
                  padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
                  child: Column(
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
                        child: Align(
                          alignment: isRTL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: DEVICE_HEIGHT * 0.005,
                            ),
                            child: QrImageView(
                              data: model.data[keyRegaInfo][keyQrUrl] ?? '',
                              size: DEVICE_HEIGHT * 0.17,
                              gapless: false,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.02,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// class Agent extends StatelessWidget {
//   const Agent({super.key, this.agentInfo});
//   final dynamic agentInfo;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const GrayLine(),
//         Padding(
//           padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               MadaText(
//                 'agent'.tr,
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w500,
//                       color: const Color(
//                         AppColors.black,
//                       ),
//                     ),
//               ),
//               SizedBox(
//                 height: DEVICE_HEIGHT * 0.02,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(
//                             DEVICE_WIDTH * 0.02,
//                           ),
//                         ),
//                         child: CachedImage(
//                           image: agentInfo[keyProfilePIC] ?? testImage,
//                           height: DEVICE_HEIGHT * 0.075,
//                           width: DEVICE_WIDTH * 0.18,
//                           placeholder: imageUser,
//                           showPlaceHolder: true,
//                         ),
//                       ),
//                       SizedBox(
//                         width: DEVICE_WIDTH * 0.04,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           MadaText(
//                             '${agentInfo[keyFirstName] ?? ''} ${agentInfo[keyLastName] ?? ''}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                   fontWeight: FontWeight.w500,
//                                   color: const Color(
//                                     AppColors.black,
//                                   ),
//                                 ),
//                           ),
//                           // MadaText(
//                           //   'view_agent_profile'.tr,
//                           //   style: Theme.of(context)
//                           //       .textTheme
//                           //       .bodyMedium!
//                           //       .copyWith(
//                           //         fontWeight: FontWeight.w400,
//                           //         color: const Color(
//                           //           AppColors.gray2,
//                           //         ),
//                           //       ),
//                           // ),
//                         ],
//                       )
//                     ],
//                   ),
//                   RotatedBox(
//                     quarterTurns: isRTL ? 2 : 0,
//                     child: SvgPicture.asset(iconArrowGrey),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class PropertyDescription extends StatelessWidget {
//   const PropertyDescription({
//     required this.description,
//     super.key,
//     this.onDescriptionPressed,
//     this.title,
//   });
//   final String description;
//   final Function()? onDescriptionPressed;
//   final String? title;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MadaText(
//                 title ?? 'property_description'.tr,
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w500,
//                       color: const Color(
//                         AppColors.black,
//                       ),
//                     ),
//               ),
//               GestureDetector(
//                 onTap: onDescriptionPressed,
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Html(
//                         data: description,
//                         style: {
//                           'body': Style(
//                             maxLines: 2,
//                             textOverflow: TextOverflow.ellipsis,
//                             padding: HtmlPaddings.zero,
//                             fontSize: FontSize(14),
//                             margin: Margins.zero,
//                             fontWeight: FontWeight.w400,
//                             fontStyle: FontStyle.normal,
//                             fontFamily: getFontFamily(
//                               Get.find<MyAppmodel>().appLocale == 'ar'
//                                   ? 'ar'
//                                   : 'en',
//                             ),
//                             color: const Color(AppColors.gray8),
//                             height: Height(DEVICE_HEIGHT * 0.08),
//                           ),
//                         },
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'read_more'.tr,
//                             style:
//                                 Theme.of(context).textTheme.bodySmall!.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(AppColors.primary),
//                                       decoration: TextDecoration.underline,
//                                       decorationColor:
//                                           const Color(AppColors.primary),
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         GrayLine(),
//       ],
//     );
//   }
// }

// class PropertyDescriptionSheet extends StatelessWidget {
//   const PropertyDescriptionSheet({required this.description, super.key});
//   final String description;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Html(data: description),
//       ],
//     );
//   }
// }

// class ReportPropertySheet extends StatelessWidget {
//   ReportPropertySheet({super.key, this.onSendReport});

//   final Function(
//     String reasonId,
//     String userType,
//     String otherDetails,
//   )? onSendReport;

//   final TextEditingmodel typeMessagemodel = TextEditingmodel();
//   String reasonId = '';
//   String userType = '';

//   @override
//   Widget build(BuildContext context) {
//     final MyAppmodel myAppmodel = Get.find<MyAppmodel>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           'report_reason'.tr,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontWeight: FontWeight.w400,
//               ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.01,
//         ),
//         MadaDropdownList(
//           label: 'select_the_reason'.tr,
//           items: myAppmodel.masterData[keyReportReason],
//           textKey: keyName,
//           valueKey: keyID,
//           onChanged: (value) {
//             reasonId = value;
//           },
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.03,
//         ),
//         Text(
//           'user_type'.tr,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontWeight: FontWeight.w400,
//               ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.01,
//         ),
//         MadaDropdownList(
//           label: 'select_the_type'.tr,
//           items: myAppmodel.masterData[keyUserTypeReason],
//           onChanged: (value) {
//             userType = value;
//           },
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.03,
//         ),
//         Text(
//           'other_comments'.tr,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.01,
//         ),
//         Text(
//           'add_your_additional_comments'.tr,
//           style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: const Color(AppColors.gray2),
//               ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.005,
//         ),
//         CustomInput(
//           model: typeMessagemodel,
//           hint: 'type_msg'.tr,
//           maxLines: 5,
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.04,
//         ),
//         CustomButton(
//           text: 'send_report'.tr,
//           onPressed: () {
//             onSendReport!(reasonId, userType, typeMessagemodel.text);
//           },
//           textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
//                 color: const Color(
//                   AppColors.white,
//                 ),
//               ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(AppColors.green3),
//             padding: EdgeInsets.symmetric(
//               vertical: DEVICE_HEIGHT * 0.019,
//               horizontal: DEVICE_WIDTH * 0.1,
//             ),
//             shadowColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(DEVICE_WIDTH * 0.08),
//                 bottomRight: Radius.circular(DEVICE_WIDTH * 0.08),
//                 topLeft: Radius.circular(DEVICE_WIDTH * 0.08),
//                 bottomLeft: Radius.circular(DEVICE_WIDTH * 0.08),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.01,
//         ),
//       ],
//     );
//   }
// }

// class RegaSheet extends StatelessWidget {
//   const RegaSheet({
//     required this.locations,
//     required this.propertySpec,
//     super.key,
//     this.regaInfo,
//   });

//   final List<dynamic> locations;
//   final List<dynamic> propertySpec;
//   final dynamic regaInfo;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         if (locations.isNotEmpty)
//           MadaText(
//             'location'.tr,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: const Color(
//                     AppColors.black,
//                   ),
//                 ),
//           ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.02,
//         ),
//         ListView.builder(
//           itemCount: locations.length,
//           shrinkWrap: true,
//           padding: EdgeInsets.zero,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (BuildContext context, int index) {
//             return TextWithValue(
//               text: locations[index][keyLabel] ?? '',
//               value: locations[index][keyValue].toString(),
//               color: index % 2 == 1
//                   ? const Color(AppColors.white)
//                   : const Color(AppColors.primary).withOpacity(0.1),
//             );
//           },
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.02,
//         ),
//         if (propertySpec.isNotEmpty)
//           MadaText(
//             'property_specification'.tr,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: const Color(
//                     AppColors.black,
//                   ),
//                 ),
//           ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.02,
//         ),
//         ListView.builder(
//           itemCount: propertySpec.length,
//           shrinkWrap: true,
//           padding: EdgeInsets.zero,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (BuildContext context, int index) {
//             return TextWithValue(
//               text: propertySpec[index][keyLabel] ?? '',
//               value: propertySpec[index][keyValue].toString(),
//               color: index % 2 == 1
//                   ? const Color(AppColors.white)
//                   : const Color(AppColors.primary).withOpacity(0.1),
//             );
//           },
//         ),
//         // REGA QR CODE
//         if (regaInfo[keyQrUrl] != null && regaInfo[keyQrUrl].isNotEmpty)
//           Padding(
//             padding: EdgeInsets.all(DEVICE_HEIGHT * 0.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   height: DEVICE_HEIGHT * 0.015,
//                 ),
//                 MadaText(
//                   'view_details_on_rega'.tr,
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: const Color(
//                           AppColors.black,
//                         ),
//                       ),
//                 ),
//                 SizedBox(
//                   height: DEVICE_HEIGHT * 0.015,
//                 ),
//                 SizedBox(
//                   width: DEVICE_WIDTH,
//                   child: Align(
//                     alignment:
//                         isRTL ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: DEVICE_HEIGHT * 0.005,
//                       ),
//                       child: QrImageView(
//                         data: regaInfo[keyQrUrl] ?? '',
//                         size: DEVICE_HEIGHT * 0.17,
//                         gapless: false,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: DEVICE_HEIGHT * 0.02,
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }
