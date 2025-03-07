import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'login_side_component_model.dart';

class LoginSideComponent extends StatefulWidget {
  const LoginSideComponent({
    super.key,
  });

  @override
  State<LoginSideComponent> createState() => _LoginSideComponent();
}

class _LoginSideComponent extends State<LoginSideComponent> {
  late LoginSideComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginSideComponentModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
          child: Container(
            decoration: BoxDecoration(
              color: FlutterMadaTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding:   EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 33.h),
            child: Column(
                children: [
                  Row(
                    children: [
                      Text(FFLocalizations.of(context).getText('login'),
                          style:   const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontFamily: AppFonts.workSans,
                            fontWeight: AppFonts.w700,
                          )),
                    ],
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      context.pushNamed('HomePage');
                    },
                    text: FFLocalizations.of(context).getText('login'),
                    options: FFButtonOptions(
                      height: 48.h,
                      padding:   EdgeInsetsDirectional.fromSTEB(181.w, 0, 181.w, 0),
                      color: FlutterMadaTheme.of(context).color8EC24D,
                      textStyle:   const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontFamily: AppFonts.workSans,
                        fontWeight: AppFonts.w600,
                      ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ],
    );
  }
}
