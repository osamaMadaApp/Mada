import '../../general_exports.dart';

class GrayLine extends StatelessWidget {
  const GrayLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DEVICE_WIDTH,
      height: DEVICE_HEIGHT * 0.005,
      decoration: const BoxDecoration(
        color: Color(AppColors.gray5),
      ),
    );
  }
}
