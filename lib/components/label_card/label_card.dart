import '../../general_exports.dart';

class LabelCard extends StatelessWidget {
  const LabelCard({
    super.key,
    this.text = '',
    this.textColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.textSize = 12,
    this.borderColor = Colors.transparent,
    this.paddingVertical,
    this.paddingHorizontal,
    this.showLabel = true,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double textSize;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final Color borderColor;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return showLabel
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal ?? (8.w),
              vertical: paddingVertical ?? (8.h),
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        : const Center();
  }
}
