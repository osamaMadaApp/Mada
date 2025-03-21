import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:pinput/pinput.dart';

import '/structure_main_flow/flutter_mada_util.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import 'otp_component_model.dart';

class OtpComponent extends StatefulWidget {
  const OtpComponent({super.key, this.onConfnfirm, this.onResendCode});

  final Future<void> Function()? onConfnfirm;
  final Future<void> Function()? onResendCode;

  @override
  State<OtpComponent> createState() => _OtpComponentWidgetState();
}

class _OtpComponentWidgetState extends State<OtpComponent>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  int remainingSeconds = 60;
  // bool? isValid;
  late OtpComponentModel _model;

  @override
  void initState() {
    super.initState();
    _model = context.read<OtpComponentModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model =
        context.watch<OtpComponentModel>(); // Using watch here instead of read
    return Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(32.w, 32.h, 32.w, 32.h),
          decoration: BoxDecoration(
            color: FlutterMadaTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.fromLTRB(24.w, 84.h, 24.w, 33.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    madaLogo,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 56.h, 0.w, 0.h),
                        child: Text(FFLocalizations.of(context).getText('code'),
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
                            FFLocalizations.of(context).getText('enter'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: FlutterMadaTheme.of(context).color000000,
                              fontFamily: AppFonts.outfit,
                              fontWeight: AppFonts.w400,
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 32.h, 0.w, 0.h),
                          child: Center(
                            child: Pinput(
                              defaultPinTheme: _model.themePin(context),
                              focusedPinTheme:
                                  _model.themePin(context).copyDecorationWith(
                                        border: Border.all(
                                          color: FlutterMadaTheme.of(context)
                                              .primary, //#D9D9D9
                                        ),
                                      ),
                              obscureText: true,
                              obscuringWidget: Container(
                                height: 16.h,
                                width: 16.w,
                                decoration: BoxDecoration(
                                  color:
                                      FlutterMadaTheme.of(context).colorD9D9D9,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              pinAnimationType: PinAnimationType.slide,
                              onChanged: (String value) {},
                              onCompleted: (String pin) {
                                if (pin.length == 4) {
                                  setState(() {
                                    _model.isValid = true;
                                  });
                                } else {
                                  setState(() {
                                    _model.isValid = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 42.h, 0.w, 0.h),
                          child: Text(
                              FFAppState().timerTimeStamp == 0
                                  ? ''
                                  : '00:${remainingSeconds.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: FlutterMadaTheme.of(context).color8EC24D,
                                fontFamily: AppFonts.outfit,
                                decoration: TextDecoration.underline,
                                fontWeight: AppFonts.w500,
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: FFAppState().timerTimeStamp <= 0
                                ? () {
                                    widget.onResendCode?.call();
                                    startTimer();
                                  }
                                : null,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0.w, 12.h, 0.w, 0.h),
                              child: Text(
                                  FFLocalizations.of(context).getText('resend'),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: FFAppState().timerTimeStamp <= 0
                                        ? FlutterMadaTheme.of(context).primary
                                        : FlutterMadaTheme.of(context)
                                            .color989898,
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
                ],
              ),
              Column(
                children: [
                  FFButtonWidget(
                    onPressed: _model.isValid == true
                        ? () async {
                            await widget.onConfnfirm?.call();
                          }
                        : null,
                    text: FFLocalizations.of(context).getText('confirm'),
                    options: FFButtonOptions(
                      height: 48.h,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(170.w, 0, 170.w, 0),
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

  // PinTheme themePin(BuildContext context) {
  //   return PinTheme(
  //     height: 76.h,
  //     width: 352.w,
  //     decoration: BoxDecoration(
  //       color: Colors.transparent,
  //       shape: BoxShape.circle,
  //       border: Border.all(
  //         color: FlutterMadaTheme.of(context).color989898,
  //       ),
  //     ),
  //   );
  // }

  void startTimer() {
    FFAppState().timerTimeStamp = DateTime.now().millisecondsSinceEpoch;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final int elapsedSeconds = ((DateTime.now().millisecondsSinceEpoch -
              FFAppState().timerTimeStamp) ~/
          1000);

      if (elapsedSeconds >= 60) {
        setState(() {
          remainingSeconds = 0; // Ensure it updates to 0 before stopping
        });
        FFAppState().timerTimeStamp = 0;
        timer.cancel();
      } else {
        setState(() {
          remainingSeconds = 60 - elapsedSeconds;
        });
      }
    });
  }
}
