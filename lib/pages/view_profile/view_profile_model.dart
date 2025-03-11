import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ViewProfileModel extends ChangeNotifier {
  ViewProfileModel() {
    getUserProfile();
  }

  dynamic data;
  bool isLoading = true;

  void pickImageAndUpload() {}

  void getUserProfile() {
    // if (Get.isBottomSheetOpen!) {
    //   Get.back();
    // }
    startLoading();
    isLoading = true;
    notifyListeners();
    ApiRequest(
      path: apiProfile,
      formatResponse: true,
      className: 'ViewProfileController/getUserProfile',
      defaultHeadersValue: false,
      header: <String, dynamic>{
        'Authorization': 'Bearer ${FFAppState().userModel[keyToken]}'
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (data[keySuccess] == true) {
          this.data = data[keyResults];
        }
        isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    consoleLog('Disposed');
    super.dispose();
  }
}
