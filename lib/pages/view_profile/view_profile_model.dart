import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ViewProfileModel extends ChangeNotifier {
  ViewProfileModel() {
    getUserProfile();
  }

  dynamic data;

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

  Future<void> changeLanguage(BuildContext context, String language) async {
    if (FFAppState().getSelectedLanguge() != language) {
      FFAppState().update(() {
        FFAppState().selectedLangugeAppState = (language == 'en') ? 1 : 0;
      });

      Provider.of<AppProvider>(context, listen: false).setLocale(language);

      data = null;
      notifyListeners();
      startLoading();

      final appState = context.read<AppProvider>();
      await appState.getMasterData();

      getUserProfile();
    }
  }

  Future<void> logout(BuildContext context) async {
    startLoading();
    ApiRequest(
      path: apiLogout,
      method: ApiMethods.put,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      defaultHeadersValue: false,
      className: 'ViewProfileModel/logout',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (response[keySuccess] == true) {
          onSignOut(context);
        }
      },
      onError: (dynamic e) {
        onSignOut(context);
      },
    );
  }

  void onSignOut(BuildContext context) {
    // should clear Local storage before
    FFAppState().clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.routeLogin,
      (Route<dynamic> route) => false,
    );
  }

  Future<void> pickImageAndUpload() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            showCropGrid: true,
            hideBottomControls: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            cropStyle: CropStyle.circle,
            embedInNavigationController: true,
            aspectRatioLockEnabled: true,
            rotateButtonsHidden: true,
            resetButtonHidden: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        final File imageFile = File(croppedFile.path);
        await updateUserImage(imageFile);
      }
    }
  }

  Future<void> updateUserImage(File image) async {
    startLoading();
    final headers = {
      'Authorization': 'Bearer ${FFAppState().userModel[keyToken]}'
    };
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl$apiUpdateProfileImage'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_pic',
        image.path,
      ),
    );

    consoleLog(request.files);
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String responseString = await response.stream.bytesToString();

      final responseJson = jsonDecode(responseString);

      final String profilePicUrl = responseJson[keyResults][keyProfilePic];
      getUserProfile();

      final dynamic userData = FFAppState().userModel;
      userData[keyProfilePic] = profilePicUrl;

      FFAppState().userModel = userData;
    } else {
      consoleLog(response.reasonPhrase);
    }
    dismissLoading();
  }

  @override
  void dispose() {
    consoleLog('Disposed');
    super.dispose();
  }
}
