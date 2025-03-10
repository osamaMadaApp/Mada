import '../../general_exports.dart';

class ViewProfileModel extends ChangeNotifier {
  ViewProfileModel() {
    consoleLog('init');
  }

  dynamic data;

  void pickImageAndUpload() {}

  // void getUserProfile() {
  //   if (Get.isBottomSheetOpen!) {
  //     Get.back();
  //   }
  //   startLoading();
  //   isLoading = true;
  //   update();
  //   ApiRequest(
  //     path: apiProfile,
  //     formatResponse: true,
  //     defaultHeadersValue: false,
  //     className: 'ViewProfileController/getUserProfile',
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) {
  //       dismissLoading();
  //       if (data[keySuccess] == true) {
  //         this.data = data[keyResults];
  //       }
  //       isLoading = false;
  //       update();
  //     },
  //     onError: (e) {
  //       isLoading = false;
  //       update();
  //     },
  //   );
  // }

  @override
  void dispose() {
    consoleLog('Disposed');
    super.dispose();
  }
}
