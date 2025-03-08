import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../components/forget_password_component/forget_password_component.dart';
import '../../components/otp_component/otp_component.dart';
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
    _model = createModel(context, () => LoginPageModel());
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Image.asset(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            'assets/images/login_main_image.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            backgroundColor:
                FlutterMadaTheme.of(context).colorFFFFFF.withOpacity(0.0),
            body: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                // Duration of the transition
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
    return wrapWithModel(
      model: _model.loginSideComponentModel,
      updateCallback: () => setState(() {}),
      child: LoginSideComponent(
        onForgetPasswordTap: () {
          setState(() {
            _model.currentModelName = 'ForgetPasswordComponent';
          });
        },
        onConfirmTap: () {
          setState(() {
            _model.currentModelName = 'OtpComponent';
          });
        },
      ),
    );
  }

  // Helper method to build LoginSideComponent
  Widget _buildOtpComponent() {
    return wrapWithModel(
      model: _model.otpComponent,
      updateCallback: () => setState(() {}),
      child: OtpComponent(
        onConfnfirm: () {
          setState(() {
            _model.currentModelName = 'OtpComponent';
          });
        },
      ),
    );
  }

// Helper method to build ForgetPasswordComponent
  Widget _buildForgetPasswordComponent() {
    return wrapWithModel(
      model: _model.forgetPasswordComponent,
      updateCallback: () => setState(() {}),
      child: ForgetPasswordComponent(
        onLoginTap: () {
          setState(() {
            _model.currentModelName = 'LoginSideComponent';
          });
        }, onConfirmTap: () {
          setState(() {
            _model.currentModelName = 'OtpComponent';
          });
        },
      ),
    );
  }
}
