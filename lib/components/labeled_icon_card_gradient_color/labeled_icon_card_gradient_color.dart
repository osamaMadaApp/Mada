import 'package:flutter_svg/svg.dart';
import '../../general_exports.dart';

class LabeledIconCardGradientColor extends StatelessWidget {
  const LabeledIconCardGradientColor(
      {super.key,
      required this.title,
      required this.icon,
      this.columnCrossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.picType = PicType.svg,
      this.onTap,
      this.textStyle});

  final String? title;
  final String? icon;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final PicType picType;
  final Function()? onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(12.w, 5.h, 135.w, 0.h),
        decoration: BoxDecoration(
          color: FlutterMadaTheme.of(context).color4CAF50FF,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: FlutterMadaTheme.of(context).primary,
          ),
          gradient: LinearGradient(
            colors: [
              FlutterMadaTheme.of(context).colorFFFFFF,
              FlutterMadaTheme.of(context).colorD2D2D2,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: columnCrossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            SizedBox(
              child: icon != null && icon!.isNotEmpty
                  ? picType == PicType.svg
                      ? SvgPicture.network(
                          icon!,
                          height: 40.h,
                          width: 40.w,
                          color: FlutterMadaTheme.of(context).primary,
                        )
                      : CachedImage(
                          image: icon,
                          height: 40.h,
                          width: 40.w,
                        )
                  : const Center(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0),
              child: MadaText(
                title ?? '',
                style: textStyle ??
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: FlutterMadaTheme.of(context).color000000,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.workSans,
                        fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
