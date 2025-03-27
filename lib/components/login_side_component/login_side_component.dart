import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '/structure_main_flow/flutter_mada_util.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import 'login_side_component_model.dart';

class LoginSideComponent extends StatefulWidget {
  const LoginSideComponent(
      {super.key, this.onForgetPasswordTap, this.onConfirmTap});

  final void Function()? onForgetPasswordTap;
  final Future<void> Function(String? email, String? password)? onConfirmTap;

  @override
  State<LoginSideComponent> createState() => _LoginSideComponent();
}

class _LoginSideComponent extends State<LoginSideComponent> {
  late LoginSideComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<LoginSideComponentModel>();
    _model.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (kDebugMode) {
        _model.textController1.text = 'sarmad@madaproperties.com';
        _model.textController2.text = 'Sar@2021\$\$';
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model = context
        .watch<LoginSideComponentModel>(); // Using watch here instead of read
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(32.w, 32.h, 32.w, 32.h),
          decoration: BoxDecoration(
            color: FlutterMadaTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.fromLTRB(24.w, 84.h, 24.w, 33.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    madaLogo,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 56.h, 0.w, 0.h),
                        child: Text(
                            FFLocalizations.of(context).getText('login'),
                            style: TextStyle(
                              fontSize: 28.0.h,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w600,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 0.h),
                        child: Text(
                            FFLocalizations.of(context).getText('enterEmail'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w400,
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 32.h, 0.w, 0.h),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _model.textController1,
                            textInputAction: TextInputAction.next,
                            focusNode: _model.textFieldFocusNode1,
                            onChanged: (String value) {
                              setState(() {
                                _model.textController1State = value.isNotEmpty;
                                _model.emailValid(value);
                              });
                            },
                            decoration: InputDecoration(
                              errorText: _model.textController1State == null
                                  ? null
                                  : _model.textController1State == false
                                      ? FFLocalizations.of(context)
                                          .getText('emailIsNoValid')
                                      : null,
                              isDense: true,
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                                color: FlutterMadaTheme.of(context).color989898,
                                fontFamily: AppFonts.outfit,
                                fontWeight: AppFonts.w400,
                              ),
                              labelText: FFLocalizations.of(context)
                                  .getText('emailAddress'),
                              floatingLabelStyle: TextStyle(
                                  color:
                                      FlutterMadaTheme.of(context).color989898),
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: FlutterMadaTheme.of(context).color989898,
                                fontFamily: AppFonts.outfit,
                                fontWeight: AppFonts.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterMadaTheme.of(context).error,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterMadaTheme.of(context).error,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              filled: true,
                              fillColor: FlutterMadaTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w400,
                            ),
                            cursorColor:
                                FlutterMadaTheme.of(context).primaryText,
                            validator: _model.textControllerValidator1
                                .asValidator(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 32.h, 0.w, 0.h),
                          child: TextFormField(
                            obscureText: !_model.passwordVisibility,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _model.textController2,
                            textInputAction: TextInputAction.done,
                            focusNode: _model.textFieldFocusNode2,
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _model.textController2State = true;
                                });
                              } else {
                                setState(() {
                                  _model.textController2State = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () => safeSetState(
                                  () => _model.passwordVisibility =
                                      !_model.passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: FlutterMadaTheme.of(context).gray600,
                                  size: 20.0,
                                ),
                              ),
                              errorText: _model.textController2State == null
                                  ? null
                                  : _model.textController2State == false
                                      ? FFLocalizations.of(context)
                                          .getText('fillEmptyForm')
                                      : null,
                              isDense: true,
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                                color: FlutterMadaTheme.of(context).color989898,
                                fontFamily: AppFonts.outfit,
                                fontWeight: AppFonts.w400,
                              ),
                              labelText: FFLocalizations.of(context)
                                  .getText('password'),
                              floatingLabelStyle: TextStyle(
                                  color:
                                      FlutterMadaTheme.of(context).color989898),
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: FlutterMadaTheme.of(context).color989898,
                                fontFamily: AppFonts.outfit,
                                fontWeight: AppFonts.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterMadaTheme.of(context).error,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterMadaTheme.of(context).error,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              filled: true,
                              fillColor: FlutterMadaTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w400,
                            ),
                            cursorColor:
                                FlutterMadaTheme.of(context).primaryText,
                            validator: _model.textControllerValidator1
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FFButtonWidget(
                    onPressed: _model.buttonEnabled() == true
                        ? () async {
                            setState(() {
                              _model.textController1State =
                                  (_model.isValidEmail ?? false);
                            });
                            if (_model.textController1State == false) {
                              return;
                            }
                            await widget.onConfirmTap?.call(
                                _model.textController1.text,
                                _model.textController2.text);
                          }
                        : null,
                    text: FFLocalizations.of(context).getText('login'),
                    options: FFButtonOptions(
                      height: 48.h,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(155.w, 0, 155.w, 0),
                      color: FlutterMadaTheme.of(context).color8EC24D,
                      textStyle: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontFamily: AppFonts.workSans,
                        fontWeight: AppFonts.w600,
                      ),
                      elevation: 0,
                      disabledColor: FlutterMadaTheme.of(context).color989898,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
