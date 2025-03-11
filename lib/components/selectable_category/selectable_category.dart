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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? FlutterMadaTheme.of(context).primary.withOpacity(0.1)
              : FlutterMadaTheme.of(context).colorD2D2D240.withOpacity(0.25),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isSelected
                ? FlutterMadaTheme.of(context).primary
                : FlutterMadaTheme.of(context).colorD2D2D240,
          ),
        ),
        child: MadaText(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
