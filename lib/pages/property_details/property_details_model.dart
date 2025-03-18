import '../../app_state.dart';
import '../../general_exports.dart';

class PropertyDetailsModel extends ChangeNotifier {
  dynamic data;
  bool isLoading = true;
  dynamic adBanner;

  void getPropertyDetails({
    Function()? action,
    dynamic propertyId,
    bool hideScreen = false,
  }) {
    if (hideScreen) {
      isLoading = true;
    }
    startLoading();
    ApiRequest(
      path: apiPropertyDetails,
      formatResponse: true,
      className: 'PropertyDetailsController/getPropertyDetails',
      queryParameters: {
        keyPropertyId: propertyId,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        if (data[keySuccess] == true) {
          this.data = data[keyResults];
          adBanner = data[keyResults][keyAdBanner];
          isLoading = false;
          action?.call();
          dismissLoading();
        }

        notifyListeners();
      },
    );
  }

  void onShowAllServicesTap() {
    // Get.bottomSheet(
    //   BottomSheetContainer(
    //     title: 'all_services'.tr,
    //     child: AllServices(
    //       services: data[keyAmenities] ?? [],
    //       projectName: data[keyTitle] ?? '',
    //     ),
    //   ),
    //   enableDrag: true,
    //   isScrollControlled: true,
    // );
  }

  void onVideoTapped() {
    // Get.toNamed(
    //   routeVideoPlayer,
    //   arguments: <String, dynamic>{
    //     keyVideoUrl: data[keyVideo][0],
    //   },
    // );
  }

  Future<void> onViewPropertyMap() async {
    // MapUtils.openMap(
    //   data[keyLocation][keyCoordinates][0],
    //   data[keyLocation][keyCoordinates][1],
    // );
  }

  void onViewBrochure() {
    // Get.toNamed(
    //   routeWebViewScreen,
    //   arguments: {
    //     keyTitle: data[keyTitle] ?? '',
    //     keyUrl: data[keyAppBrochure] ?? '',
    //     keyProjectBrouchure: true,
    //     keySubtitle: 'property_brochure'.tr,
    //   },
    // );
  }

  void onOwnProperty() {
    // if (myAppController.userData == null) {
    //   myAppController.openSignInSheet(
    //     action: () {
    //       getPropertyDetails(hideScreen: true, action: onOwnProperty);
    //     },
    //   );
    //   return;
    // }
    // if (data[keyOpenContactPopup]) {
    //   Get.bottomSheet(
    //     BottomSheetContainer(
    //       title: 'confirm_your_data'.tr,
    //       child: ContactTeamSheet(
    //         whatsappMsg:
    //             '${data[keyTitle] ?? ''}\n${data[keyPropertyCategory] ?? ''}\n${data[keyPrice] ?? 0} ${getCurrency()}\n${data[keyCity] ?? ''} - ${data[keyCommunity] ?? ''} - ${data[keySubCommunity] ?? ''}',
    //       ),
    //     ),
    //     isScrollControlled: true,
    //   );
    //   return;
    // }
    // if (myAppController.appCountry == 'SA' &&
    //     myAppController.userData[keyIsNafathVerified] == 0) {
    //   myAppController.openNafathVerificationSheet();
    //   return;
    // }
    // Get.toNamed(
    //   routePayment,
    //   arguments: {
    //     keyPropertyId: propertyId,
    //   },
    // );
  }

  void onDescriptionPressed() {
    // Get.bottomSheet(
    //   BottomSheetContainer(
    //     title: 'property_description'.tr,
    //     titlePadding: DEVICE_HEIGHT * 0.02,
    //     child: PropertyDescriptionSheet(
    //       description: data[keyDescription],
    //     ),
    //   ),
    //   isScrollControlled: true,
    // );
  }

  void threeSixtyUrlPressed() {
    // Get.toNamed(
    //   routeWebViewScreen,
    //   arguments: {
    //     keyTitle: data[keyTitle] ?? '',
    //     keyUrl: data[keyUrl360] ?? ''
    //   },
    // );
  }

  void reportProperty() {
    // if (myAppController.userData == null) {
    //   myAppController.openSignInSheet();
    //   return;
    // }

    // Get.bottomSheet(
    //   BottomSheetContainer(
    //     title: 'report_this_property'.tr,
    //     child: ReportPropertySheet(
    //       onSendReport: (reasonId, userType, otherDetails) {
    //         onSendReport(reasonId, userType, otherDetails);
    //       },
    //     ),
    //   ),
    //   isScrollControlled: true,
    // );
  }

  void onSendReport(
    String reasonId,
    String userType,
    String otherDetails,
    BuildContext context,
  ) {
    startLoading();
    ApiRequest(
      path: apiReportProperty,
      method: ApiMethods.post,
      className: 'PropertyDetailsController/onSendReport',
      defaultHeadersValue: false,
      body: {
        keyPropertyId: data[keyID],
        keyReasonId: reasonId,
        keyUserTypeReason: userType,
        keyComment: otherDetails,
      },
    ).request(
      onSuccessWithHeader: (dynamic data, dynamic response, dynamic headers) {
        dismissLoading();
        if (response[keySuccess] == true) {
          Navigator.pop(context);
        }
        showToast(response[keyMsg]);
      },
    );
  }

  double getMonthlyPayment() {
    double monthlyPayment = 0;
    final double remainAmount = data[keyPrice] -
        calculateDownPaymentPercentage(
          FFAppState()
              .masterDateJsonModel[keyMortgageDownPaymentPercentage]
              .toDouble(),
        );
    final double interest = (remainAmount *
            double.parse(data[keyPropertyAmountDetail]['ratePercent'])) /
        100;
    final double totalInterest =
        interest * FFAppState().masterDateJsonModel[keyLoanTenure].toDouble();
    final double perMonth = (remainAmount + totalInterest) /
        (FFAppState().masterDateJsonModel[keyLoanTenure].toDouble() * 12);
    monthlyPayment = perMonth;
    return monthlyPayment;
  }

  double calculateDownPaymentPercentage(double percentage) {
    return (percentage / 100) * data[keyPrice];
  }
}
