import '../../general_exports.dart';
import '../../main.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ViewProfileModel extends ChangeNotifier {
  ViewProfileModel() {
    getUserProfile();
    consoleLog(FFAppState().masterDateJsonModel);
  }

  dynamic data;

  void pickImageAndUpload() {}

  void getUserProfile() {
    startLoading();

    ApiRequest(
      path: apiProfile,
      formatResponse: true,
      className: 'ViewProfileController/getUserProfile',
      defaultHeadersValue: false,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        if (data[keySuccess] == true) {
          this.data = data[keyResults];
        }

        dismissLoading();
        notifyListeners();
      },
    );
  }

  void changeLanguage(BuildContext context, String language) {
    if (FFAppState().getSelectedLanguge() != language) {
      FFAppState().update(
        () {
          FFAppState().selectedLangugeAppState = language == 'en' ? 1 : 0;
        },
      );

      MyApp.of(context).setLocale(language);

      // should call master data again
      
    }
  }

  @override
  void dispose() {
    consoleLog('Disposed');
    super.dispose();
  }
}
