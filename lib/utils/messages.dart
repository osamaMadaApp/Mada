import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

enum MessageTypes {
  basic,
  success,
  error,
  warning,
  info,
}

void showMessage({
  String? description,
  MessageTypes? type,
  int? textColor,
  bool withBackground = true,
  int duration = 3,
}) {
  final Color fontColor = type == MessageTypes.success
      ? const Color(0xff287D3C) // success
      : type == MessageTypes.error
          ? const Color(0xffDA1414) // error
          : type == MessageTypes.warning
              ? const Color(0xffB95000) // warning
              : type == MessageTypes.info
                  ? const Color(0xff2E5AAC) // info
                  : Colors.black; // basic

  final Color backgroundColor = type == MessageTypes.success
      ? const Color(0xffEDF9F0) // success
      : type == MessageTypes.error
          ? const Color(0xffFEEFEF) // error
          : type == MessageTypes.warning
              ? const Color(0xffFFF4EC) // warning
              : type == MessageTypes.info
                  ? const Color(0xffEEF2FA) // info
                  : Colors.white.withOpacity(0.8); // basic

  Get.snackbar(
    '',
    '',
    titleText: const SizedBox(
      width: 0,
      height: 0,
    ),
    messageText: Text(
      description!,
      style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
            color: fontColor,
          ),
    ),
    icon: Icon(
      Icons.info,
      color: fontColor,
    ),
    mainButton: TextButton(
      onPressed: null,
      child: GestureDetector(
        onTap: Get.closeCurrentSnackbar,
        child: SvgPicture.asset(
          iconClose,
          colorFilter: ColorFilter.mode(fontColor, BlendMode.srcIn),
          width: 0.05.w,
          height: 0.05.h,
        ),
      ),
    ),
    backgroundColor: backgroundColor,
    duration: Duration(seconds: duration),
  );
}

/// show popup
void showPopUp({Widget? child}) {
  Get.dialog(
    child!,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
  );
}
