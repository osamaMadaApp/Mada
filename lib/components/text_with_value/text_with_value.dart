import '../../general_exports.dart';

class TextWithValue extends StatelessWidget {
  const TextWithValue({
    required this.text,
    required this.value,
    super.key,
    this.color,
    this.isPrice = false,
    this.textStyle,
    this.middleValue,
    this.mainAxisAlignment,
    this.width,
  });
  final Color? color;
  final String text;
  final String value;
  final bool isPrice;
  final TextStyle? textStyle;
  final String? middleValue;
  final MainAxisAlignment? mainAxisAlignment;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
      decoration: BoxDecoration(
        color: color ?? const Color(AppColors.primary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: DEVICE_WIDTH * 0.5,
              ),
              child: MadaText(
                text,
                style: textStyle ??
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(
                            AppColors.black,
                          ),
                        ),
              ),
            ),
          ),
          if (middleValue != null)
            Container(
              constraints: BoxConstraints(
                maxWidth: DEVICE_WIDTH * 0.5,
              ),
              child: MadaText(
                middleValue!,
                textAlign: TextAlign.end,
                style: textStyle ??
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(
                            AppColors.black,
                          ),
                        ),
              ),
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: DEVICE_WIDTH * 0.5,
            ),
            child: MadaText(
              isPrice
                  ? '${getFormattedPrice(double.parse(value))} ${getCurrency()}'
                  : value,
              textAlign: TextAlign.end,
              style: textStyle ??
                  Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(
                          AppColors.black,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
