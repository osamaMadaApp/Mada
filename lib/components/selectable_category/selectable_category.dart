import '../../general_exports.dart';

class SelectableCategory extends StatelessWidget {
  const SelectableCategory({
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String text;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? FlutterMadaTheme.of(context).primary.withOpacity(0.1)
              : FlutterMadaTheme.of(context).gray600,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? FlutterMadaTheme.of(context).primary
                : FlutterMadaTheme.of(context).gray600,
          ),
        ),
        child: MadaText(
          text.tr,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
