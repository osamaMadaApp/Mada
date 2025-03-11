
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import '../../utils/assets.dart';
import 'forget_password_component_model.dart';

class ForgetPasswordComponent extends StatefulWidget {
  const ForgetPasswordComponent({
    super.key,
    this.onLoginTap,
    this.onConfirmTap
  });

  final void Function()? onLoginTap;
  final void Function()? onConfirmTap;


  @override
  State<ForgetPasswordComponent> createState() => _ForgetPasswordComponentWidgetState();
}

class _ForgetPasswordComponentWidgetState extends State<ForgetPasswordComponent>
    with TickerProviderStateMixin {
  late ForgetPasswordComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<ForgetPasswordComponentModel>();
    _model.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model = context.watch<ForgetPasswordComponentModel>(); // Using watch here instead of read
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
                        child: Text(FFLocalizations.of(context).getText('forgetPassword'),
                            style: TextStyle(
                              fontSize: 28.0.h,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w600,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 0.h),
                        child:
                        Text(FFLocalizations.of(context).getText('rest'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w400,
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
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
                                  color: FlutterMadaTheme.of(context).color989898),
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: FlutterMadaTheme.of(context).color989898,
                                fontFamily: AppFonts.outfit,
                                fontWeight: AppFonts.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterMadaTheme.of(context).colorE1E1E1,
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
                              fillColor:
                              FlutterMadaTheme.of(context).secondaryBackground,
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w400,
                            ),
                            cursorColor: FlutterMadaTheme.of(context).primaryText,
                            validator: _model.textControllerValidator1
                                .asValidator(context),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onLoginTap,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 0.h),
                          child: Text(
                              FFLocalizations.of(context).getText('backToLogin'),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: FlutterMadaTheme.of(context).color8EC24D,
                                fontFamily: AppFonts.outfit,
                                decoration: TextDecoration.underline,
                                fontWeight: AppFonts.w400,
                              )),
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
                    onPressed: _model.buttonEnabled() == true ? () {
                      setState(() {
                        _model.textController1State =  (_model.isValidEmail ?? false);
                      });
                      if(_model.textController1State == false){
                        return;
                      }
                      widget.onConfirmTap?.call();
                    } : null,
                    text: FFLocalizations.of(context).getText('confirm'),
                    options: FFButtonOptions(
                      height: 48.h,
                      padding:  EdgeInsetsDirectional.fromSTEB(170.w, 0, 170.w, 0),
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
