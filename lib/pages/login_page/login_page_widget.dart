import 'package:flutter/scheduler.dart';

import '/structure_main_flow/flutter_mada_util.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../components/login_side_component/login_side_component.dart';
import '../../general_exports.dart';
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
    _model =
        context.watch<LoginPageModel>(); // Using watch here instead of read
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
                loginMainImage,
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
                child: _buildLoginSideComponent(),
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
      onConfirmTap: (String? email , String? password) async {
        final Map<String, dynamic> deviceInfo = await getDeviceInfo();
        final String fcId = await getFcmToken() ?? '';

        await ApiRequest(
          path: apiLogin,
          method: ApiMethods.post,
          className: 'MyAppController/login',
          defaultHeadersValue: false,
          body: {
            keyEmail: email,
            keyPassword: password,
            keyDeviceId: deviceInfo[keyDeviceId],
            keyDeviceType: deviceInfo[keyDeviceModel],
            keyDeviceToken: fcId
          },
        ).request(
          onSuccess: (dynamic data, dynamic response) {
            if (response[keySuccess] == true) {
              FFAppState().userModel = response['results'];
              Navigator.pushNamed(context, Routes.routeNavBar);
            } else {
              showToast(response[keyMsg]);
            }
          },
        );
      },
    );
  }

}
