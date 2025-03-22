import '../../general_exports.dart';

class CompanyOrProjectSection extends StatelessWidget {
  const CompanyOrProjectSection({
    required this.name,
    required this.developerImage,
    super.key,
    this.onTap,
    this.companyName,
    this.showRealEstateTxt = true,
  });
  final String name;
  final String developerImage;
  final String? companyName;
  final Function()? onTap;
  final bool showRealEstateTxt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DEVICE_HEIGHT * 0.02,
          vertical: DEVICE_HEIGHT * 0.02,
        ),
        decoration: BoxDecoration(
          color: const Color(AppColors.gray4).withOpacity(0.15),
          borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
              child: CachedImage(
                height: 40.w,
                width: 40.w,
                image: developerImage,
              ),
            ),
            SizedBox(
              width: DEVICE_WIDTH * 0.01,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MadaText(
                    name,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: const Color(
                            AppColors.black,
                          ),
                        ),
                  ),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.005,
                  ),
                  if ((showRealEstateTxt && companyName != null))
                    Row(
                      children: [
                        SizedBox(
                          width: DEVICE_WIDTH * 0.6,
                          child: MadaText(
                            '${FFLocalizations.of(context).getText('real_estate_developer')}-${companyName!}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: const Color(AppColors.gray2),
                                      fontSize: 12,
                                      // decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
