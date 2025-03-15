import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../backend/schema/util/schema_util.dart';
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

  void onEditProfileInfo(BuildContext context) {
    SideSheet.show(
      context,
      child: ChangeProfileInfo(
        firstName: data[keyFirstName],
        lastName: data[keyLastName],
        email: data[keyEmail],
        isNafathVerified: data[keyIsNafathVerified] == 1,
        nationalId: data[keyNationalID],
        shouldShowNationalId:
            data[keyCountryCODE] == '966' && data[keyIsNafathVerified] == 0,
        onChangeInfo: (firstName, lastName, email, nationId) {
          updateProfile(firstName, lastName, email, nationId, context);
        },
      ),
      title: FFLocalizations.of(context).getText('change_profile_info'),
    );
  }

  Future<void> updateProfile(String firstName, String lastName, String email,
      String? nationId, BuildContext context) async {
    if (firstName.isEmpty || lastName.isEmpty) {
      showToast(
          FFLocalizations.of(context).getText('please_fill_profile_info'));
      return;
    }
    if (firstName == data[keyFirstName] &&
        lastName == data[keyLastName] &&
        email == data[keyEmail] &&
        (nationId == data[keyNationalID] || nationId!.isEmpty)) {
      Navigator.pop(context);
      return;
    }

    final String fcId = await getFcmToken() ?? '';

    startLoading();
    ApiRequest(
      path: apiUpdateProfile,
      method: ApiMethods.put,
      defaultHeadersValue: false,
      className: 'ViewProfileController/updateProfile',
      body: {
        keyFirstName: firstName,
        keyLastName: lastName,
        keyEmail: email,
        keyDeviceToken: fcId,
        keyNationalID: nationId,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (response[keySuccess] == true) {
          this.data = null;
          notifyListeners();
          final dynamic userData = FFAppState().userModel;
          userData[keyFirstName] = data[keyResults][keyFirstName] ?? '';
          userData[keyLastName] = data[keyResults][keyLastName] ?? '';
          userData[keyEmail] = data[keyResults][keyEmail] ?? '';

          consoleLog(FFAppState().userModel);

          getUserProfile();
          Navigator.pop(context);
        } else {
          showToast(response[keyMsg]);
        }
      },
    );
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

  void onDeleteAccount(BuildContext context) {
    SideSheet.show(
      context,
      child: const DeleteAccountSheet(),
      title: FFLocalizations.of(context).getText('delete_account_!'),
    );
  }

  @override
  void dispose() {
    consoleLog('Disposed');
    super.dispose();
  }
}
