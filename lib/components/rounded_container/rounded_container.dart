import '../../general_exports.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    required this.child,
    this.color,
    this.onTap,
    this.boxShadow,
    this.minHeight = 0.1,
    this.borderRadius = 10,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.withPadding = true,
    this.minWidth,
    super.key,
  });

  final Color? color;
  final Widget child;
  final Function()? onTap;
  final double minHeight;
  final BoxShadow? boxShadow;
  final bool withPadding;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap?.call,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight,
          minWidth: minWidth ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color ?? FlutterMadaTheme.of(context).gray600,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          boxShadow: boxShadow == null
              ? null
              : <BoxShadow>[
                  boxShadow!,
                ],
        ),
        padding: withPadding
            ? EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 16.h,
              )
            : null,
        child: child,
      ),
    );
  }
}
