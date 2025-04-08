import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class LabeledIconCard extends StatelessWidget {
  const LabeledIconCard({
    required this.title,
    required this.icon,
    super.key,
    this.columnCrossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.picType = PicType.svg,
    this.onTap,
    this.minWidth,
    this.maxWidth,
    this.textStyle,
    this.horizontalPadding,
    this.iconWidth,
    this.iconHeight,
    this.verticalPadding,
  });

  final String? title;
  final String? icon;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final PicType picType;
  final Function()? onTap;
  final double? minWidth;
  final double? maxWidth;
  final TextStyle? textStyle;
  final double? horizontalPadding;
  final double? iconWidth;
  final double? iconHeight;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 36.w,
          maxWidth: maxWidth ?? double.infinity,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 21.h,
          horizontal: horizontalPadding ?? 12.w,
        ),
        decoration: BoxDecoration(
          color: FlutterMadaTheme.of(context).color8EC24D,
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          crossAxisAlignment: columnCrossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            SizedBox(
              height: iconHeight ?? 90.h,
              width: iconWidth ?? 52.h,
              child: icon != null && icon!.isNotEmpty
                  ? picType == PicType.svg
                      ? SvgPicture.network(
                          icon!,
                          height: 45.h,
                          colorFilter: ColorFilter.mode(
                            FlutterMadaTheme.of(context).colorFFFFFF,
                            BlendMode.srcIn,
                          ),
                        )
                      : CachedImage(
                          image: icon,
                          height: 0.045.h,
                        )
                  : const Center(),
            ),
            SizedBox(height: 0.015.h),
            MadaText(
              title ?? '',
              style: textStyle ??
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: FlutterMadaTheme.of(context).colorFFFFFF,
                      fontWeight: AppFonts.w600,
                      fontSize: 24,
                      fontFamily: AppFonts.workSans),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
