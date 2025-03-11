import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../api/api_keys.dart';
import '../../api/api_request.dart';
import '../../api/api_routes.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../components/forget_password_component/forget_password_component.dart';
import '../../components/otp_component/otp_component.dart';
import '../../general_exports.dart';
import '/structure_main_flow/flutter_mada_theme.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import '../../components/login_side_component/login_side_component.dart';
import 'login_page_model.dart';

export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _model = context.read<LoginPageModel>();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model = context.watch<LoginPageModel>(); // Using watch here instead of read
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                'assets/images/login_main_image.png',
                fit: BoxFit.cover,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color:
                FlutterMadaTheme.of(context).color000000.withOpacity(0.40),
              ),
            ],
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: _model.currentModelName == 'LoginSideComponent'
                    ? _buildLoginSideComponent()
                    : (_model.currentModelName == 'OtpComponent'
                    ? _buildOtpComponent()
                    : _buildForgetPasswordComponent()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build LoginSideComponent
  Widget _buildLoginSideComponent() {
    return LoginSideComponent(
      onForgetPasswordTap: () {
        setState(() {
          _model.currentModelName = 'ForgetPasswordComponent';
        });
      },
      onConfirmTap: () async {
        final Map<String, dynamic> deviceInfoDetails = await getDeviceInfo();
        await ApiRequest(
          path: apiLogin,
          method: ApiMethods.post,
          className: 'MyAppController/login',
          defaultHeadersValue: false,
          body: {
            keyCountryCode: 966,
            keyMobile: 595106753,
            ...deviceInfoDetails,
          },
        ).request(
          onSuccess: (dynamic data, dynamic response) {
            if (response[keySuccess] == true) {
              setState(() {
                _model.currentModelName = 'OtpComponent';
              });
            } else {
              showToast(message: response[keyMsg]);
            }
          },
        );
      },
    );
  }

  Future<void> resendCode() async {
    final String fcId = await getFcmToken() ?? '';
    ApiRequest(
      path: apiResendOTP,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      className: 'MyAppController/resendCode',
      body: {
        keyCountryCode: 966,
        keyMobile: 595106753,
        keyDeviceToken: fcId,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {},
    );
  }

  // Helper method to build LoginSideComponent
  Widget _buildOtpComponent() {
    return OtpComponent(
      onConfnfirm: () async {
        final Map<String, dynamic> deviceInfo = await getDeviceQueryParams();
        final String fcId = await getFcmToken() ?? '';
        ApiRequest(
          path: apiVerifyOtp,
          method: ApiMethods.post,
          className: 'MyAppController/verifyOtp',
          header: {
            keyLanguage: FFAppState().getSelectedLanguge(),
          },
          defaultHeadersValue: false,
          body: {
            keyCountryCode: 966,
            keyMobile: 595106753,
            keyOtpPhone: 1234,
            keyDeviceId: deviceInfo[keyDeviceId],
            keyDeviceType: deviceInfo[keyDeviceModel],
            keyDeviceToken: fcId,
          },
        ).request(
          onSuccessWithHeader:
              (dynamic data, dynamic response, dynamic headers) {
            if (response[keySuccess] == true) {
              FFAppState().userModel = response['results'];
              context.pushNamed('HomePage');
            } else {
              showToast(message: response[keyMsg]);
            }
          },
        );
      },
      onResendCode: () async {
        resendCode();
      },
    );
  }

// Helper method to build ForgetPasswordComponent
  Widget _buildForgetPasswordComponent() {
    return ForgetPasswordComponent(
      onLoginTap: () {
        setState(() {
          _model.currentModelName = 'LoginSideComponent';
        });
      },
      onConfirmTap: () {
        setState(() {
          _model.currentModelName = 'OtpComponent';
        });
      },
    );
  }
}
