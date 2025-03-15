import '../../general_exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.onPressed,
    this.text,
    this.style,
    this.textStyle,
    super.key,
    this.borderRadius,
  });

  final Function? onPressed;
  final String? text;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: FlutterMadaTheme.of(context).color8EC24D,
            padding: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 10.w,
            ),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.h),
            ),
          ),
      child: Text(
        text ?? '',
        style: textStyle ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: FlutterMadaTheme.of(context).colorFFFFFF,
                ),
      ),
    );
  }
}
