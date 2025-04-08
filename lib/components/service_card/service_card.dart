import '../../general_exports.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    required this.name,
    super.key,
    this.icon,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });
  final String? icon;
  final String name;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DEVICE_HEIGHT * 0.09,
      width: DEVICE_WIDTH * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
        border: Border.all(
          color: const Color(AppColors.gray6),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DEVICE_WIDTH * 0.01,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              SizedBox(
                height: DEVICE_HEIGHT * 0.03,
                child: CachedImage(
                  image: icon,
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.02,
            ),
            MadaText(
              name,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      AppColors.black,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
