import '../../general_exports.dart';

class ResetFilter extends StatelessWidget {
  const ResetFilter({
    super.key,
    this.onResetFilter,
    this.iconHeight,
    this.textStyle,
    this.horizontalPadding,
  });
  final Function()? onResetFilter;
  final double? iconHeight;
  final TextStyle? textStyle;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onResetFilter,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: DEVICE_WIDTH * 0.02,
              vertical: DEVICE_HEIGHT * 0.009,
            ),
            decoration: BoxDecoration(
              color: const Color(AppColors.gray),
              borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.04),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  FFLocalizations.of(context).getText('reset_filter'),
                  style: textStyle ??
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                ),
                SizedBox(width: horizontalPadding ?? DEVICE_WIDTH * 0.02),
                SizedBox(
                  height: iconHeight,
                  child: SvgPicture.asset(iconRedRoundedClose),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
