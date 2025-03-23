import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_state.dart';
import '../../backend/schema/structs/index.dart';
import '../../utils/index.dart';

class PaymentStatusDialog extends StatelessWidget {
  const PaymentStatusDialog({
    required this.title,
    required this.message,
    required this.status,
    required this.icon,
    required this.textColor,
    super.key,
  });
  final String title;
  final String message;
  final String status;
  final String icon;
  final Color textColor;

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String status,
    required String icon,
    Color textColor = Colors.green,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PaymentStatusDialog(
          title: title,
          message: message,
          status: status,
          icon: icon,
          textColor: textColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.h),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 40.h),
                SvgPicture.asset(
                  icon,
                ),
                SizedBox(height: 10.h),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 270.w,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Positioned(
            top: 15.h,
            left: FFAppState().selectedLangugeAppState == 0 ? 10.w : null,
            right: FFAppState().selectedLangugeAppState == 0 ? null : 10.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPictureRtl.asset(iconAix),
            ),
          ),
        ],
      ),
    );
  }
}
