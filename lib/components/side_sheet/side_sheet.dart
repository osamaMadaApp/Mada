import '../../general_exports.dart';

class SideSheet {
  static void show(
    BuildContext context, {
    required Widget child,
    required String title,
    double widthFactor = 0.35,
    bool barrierDismissible = true,
    bool withCloseButton = true,
    Function()? onClosingSheet,
  }) {
    // Determine direction based on locale (LTR or RTL)
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
          child: Material(
            color: Colors.white,
            elevation: 5,
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * widthFactor,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 100.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                    spacing: 30.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          if (withCloseButton)
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: GestureDetector(
                                  onTap: onClosingSheet ??
                                      () {
                                        Navigator.pop(context);
                                      },
                                  child: SvgPicture.asset(iconAix),
                                ),
                              ),
                            ),
                        ],
                      ),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: isRTL ? const Offset(1, 0) : const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
