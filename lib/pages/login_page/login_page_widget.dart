import 'package:Mada/backend/api_requests/api_calls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../../backend/schema/structs/user_model_struct.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import '/structure_main_flow/flutter_mada_theme.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: FFAppState().isGust
              ? const Size.fromHeight(50.0)
              : const Size.fromHeight(0.0),
          child: Visibility(
            visible: FFAppState().isGust,
            child: AppBar(
              backgroundColor: FlutterMadaTheme.of(context).colorFFFFFF,
              automaticallyImplyLeading: false,
              actions: const [],
              flexibleSpace: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: FlutterMadaTheme.of(context).primary,
                            size: 30.0,
                          ),
                        )),
                  ],
                ),
              ),
              elevation: 0.0,
            ),
          ),
        ),
        backgroundColor: FlutterMadaTheme.of(context).colorFFFFFF,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        FFLocalizations.of(context).getVariableText(
                            enText: 'My Car', arText: 'سيارتي'),
                        style: const TextStyle(
                          fontSize: 35.0,
                          color: Color(0xFFF7C475),
                        ).withFont(
                          fontFamily: AppFonts.quicksand,
                          fontWeight: AppFonts.bold,
                        )),
                  ],
                ),
                Container(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 10.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            final user =
                                await authManager.signInWithGoogle(context);
                            if (user == null) {
                              return;
                            }
                            User? userOn = FirebaseAuth.instance.currentUser;
                            String? idToken = await userOn?.getIdToken(true);
                            _model.loginCall = await MyCarApiGroupGroup
                                .loginCall
                                .call(tokenId: idToken);
                            if ((_model.loginCall?.jsonBody?['user'] != true)) {
                              FFAppState()
                                  .updateUserModelAppStateStruct((value) {
                                value.name = user.displayName;
                                value.name = user.authUserInfo.displayName;
                                value.id = (UserModelStruct.maybeFromMap(_model
                                            .loginCall?.jsonBody?['user']) ??
                                        UserModelStruct())
                                    .id;
                              });
                              FFAppState()
                                  .updateTokenModelStruct((value) {
                                value.token = _model.loginCall?.jsonBody?['user']['token'];
                              });
                              context.goNamedAuth('HomePage', context.mounted);
                            } else {
                              error(
                                  context,
                                  FocusNode(),
                                  _model.loginCall?.jsonBody != null
                                      ? (_model.loginCall?.jsonBody['message']
                                              .toString() ??
                                          _model.loginCall?.bodyText)
                                      : _model.loginCall?.bodyText);
                            }
                          },
                          text: FFLocalizations.of(context).getVariableText(
                              enText: 'Login With Google',
                              arText: 'تسجيل دخول بواسطة جوجل'),
                          icon: SvgPicture.asset(
                            'assets/images/google.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.contain,
                          ),
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterMadaTheme.of(context).colorFFFFFF,
                            textStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ).withFont(
                              fontFamily: AppFonts.lato,
                              fontWeight: AppFonts.bold,
                            ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            final user =
                                await authManager.signInWithApple(context);
                            if (user == null) {
                              return;
                            }
                            User? userOn = FirebaseAuth.instance.currentUser;
                            String? idToken = await userOn?.getIdToken(true);
                            _model.loginCall = await MyCarApiGroupGroup
                                .loginCall
                                .call(tokenId: idToken);
                            if ((_model.loginCall?.jsonBody?['user'] != true)) {
                              FFAppState()
                                  .updateUserModelAppStateStruct((value) {
                                value.name = user.displayName;
                                value.name = user.authUserInfo.displayName;
                              });
                              FFAppState().TokenModel.token = _model.loginCall?.jsonBody?['user']['token'];
                              FFAppState()
                                  .updateUserModelAppStateStruct((value) {
                                value = UserModelStruct.maybeFromMap(
                                        _model.loginCall?.jsonBody?['user']) ??
                                    UserModelStruct();
                              });
                              context.goNamedAuth('HomePage', context.mounted);
                            } else {
                              error(
                                  context,
                                  FocusNode(),
                                  _model.loginCall?.jsonBody != null
                                      ? (_model.loginCall?.jsonBody['message']
                                              .toString() ??
                                          _model.loginCall?.bodyText)
                                      : _model.loginCall?.bodyText);
                            }
                          },
                          text: FFLocalizations.of(context).getVariableText(
                              enText: 'Login with Apple',
                              arText: 'الدخول بواسطة ابل'),
                          icon: SvgPicture.asset(
                            'assets/images/apple.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.contain,
                          ),
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterMadaTheme.of(context).colorFFFFFF,
                            textStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ).withFont(
                              fontFamily: AppFonts.lato,
                              fontWeight: AppFonts.regular,
                            ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 22.0, 16.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          final user =
                              await authManager.signInAnonymously(context);
                          if (user == null) {
                            return;
                          }
                          User? userOn = FirebaseAuth.instance.currentUser;
                          String? idToken = await userOn?.getIdToken(true);
                          _model.loginCall = await MyCarApiGroupGroup.loginCall
                              .call(tokenId: idToken);
                          if ((_model.loginCall?.jsonBody?['user'] != true)) {
                            FFAppState().updateUserModelAppStateStruct((value) {
                              value = UserModelStruct.maybeFromMap(
                                      _model.loginCall?.jsonBody?['user']) ??
                                  UserModelStruct();
                            });
                            context.goNamedAuth('HomePage', context.mounted);
                          } else {
                            error(
                                context,
                                FocusNode(),
                                _model.loginCall?.jsonBody != null
                                    ? (_model.loginCall?.jsonBody['message']
                                            .toString() ??
                                        _model.loginCall?.bodyText)
                                    : _model.loginCall?.bodyText);
                          }
                        },
                        child: Text(
                          FFLocalizations.of(context).getVariableText(
                              enText: 'Continue as a guest',
                              arText: 'الاكمال كضيف'),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ).withFont(
                            fontFamily: AppFonts.lato,
                            fontWeight: AppFonts.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
