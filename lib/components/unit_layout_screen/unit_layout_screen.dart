import '../../general_exports.dart';

class UnitLayoutScreen extends StatelessWidget {
  const UnitLayoutScreen(
      {super.key, this.unitNumber, this.onClose, this.title, this.image});

  final Function()? onClose;
  final String? unitNumber;
  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: DEVICE_HEIGHT * 0.02,
          ),
          child: MadaText(
            '$title',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: const Color(AppColors.gray2),
            ),
          )
        ),
        InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedImage(
            width: DEVICE_WIDTH,
            height: DEVICE_HEIGHT,
            fit: BoxFit.contain,
            image: image,

          ),
        ),
      ],
    );
  }
}
