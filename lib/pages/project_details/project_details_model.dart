import 'package:flutter_html/flutter_html.dart';

import '../../app_state.dart';
import '../../general_exports.dart';

class ProjectDetailsModel extends ChangeNotifier {
  dynamic data;
  bool isLoading = true;
  dynamic adBanner;
  bool isPaymentPlanExpanded = false;

  void getProjectDetails({
    Function()? action,
    dynamic projectId,
    bool hideScreen = false,
  }) {
    if (hideScreen) {
      isLoading = true;
    }
    startLoading();
    ApiRequest(
      path: apiProjectDetails,
      formatResponse: true,
      className: 'ProjectDetailsModel/getProjectDetails',
      queryParameters: {
        keySlug: projectId,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        if (data[keySuccess] == true) {
          this.data = data[keyResults];
          adBanner = data[keyResults][keyAdBanner];
          // these comments are for testing purposes
          // this.data[keyVideo][0] =
          //     'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4';
          // this.data[keyUrl360] =
          //     'https://kuula.co/share/7vQzR?fs=1&vr=1&thumbs=1&inst=0';
          // this.data[keyAppBrochure] =
          //     'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
          // this.data[keyVideoImage] =
          //     'https://img.freepik.com/free-photo/hand-presenting-model-house-home-loan-campaign_53876-104970.jpg?semt=ais_hybrid';

          isLoading = false;
          action?.call();
          dismissLoading();
        }

        notifyListeners();
      },
    );
  }

  void onPaymentPlanExpanded() {
    isPaymentPlanExpanded = !isPaymentPlanExpanded;
    notifyListeners();
  }

  Future<void> onViewProjectMap() async {
    MapUtils.openMap(
      data[keyLocation][keyCoordinates][0],
      data[keyLocation][keyCoordinates][1],
    );
  }

  void onSendReport(
    String reasonId,
    String userType,
    String otherDetails,
    Function()? onSuccess,
  ) {
    startLoading();
    ApiRequest(
      path: apiReportProperty,
      method: ApiMethods.post,
      className: 'PropertyDetailsModel/onSendReport',
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
          onSuccess!();
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

  void addToFollow(BuildContext context) {
    final favoritesModel = context.read<FavoritesModel>();
    favoritesModel.addOrRemoveFromFavorite(
      data[keyID],
      PropertyType.project,
      onSuccessLogin: () {
        getProjectDetails(projectId: data[keyID]);
      },
      onRequestSuccess: () {
        data[keyIsFollowed] = !data[keyIsFollowed];
        notifyListeners();
      },
      bodyKey: keyProjectId,
    );
  }

  void onDescriptionPressed(BuildContext context) {
    SideSheet.show(
      context,
      child: Html(data: data[keyDescription]),
      title: FFLocalizations.of(context).getText('project_description'),
    );
  }
}
