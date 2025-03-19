import '../../general_exports.dart';

class ComponentGeneralInformation extends StatelessWidget {
  const ComponentGeneralInformation({
    required this.name,
    required this.priceStarts,
    required this.city,
    required this.community,
    super.key,
    this.priceText,
    this.showPriceText = false,
  });
  final String name;
  final int? priceStarts;
  final String city;
  final String community;
  final String? priceText;
  final bool showPriceText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: DEVICE_HEIGHT * 0.02,
        right: DEVICE_HEIGHT * 0.02,
        bottom: DEVICE_HEIGHT * 0.02,
        top: DEVICE_HEIGHT * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 550.w,
                child: MadaText(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(
                          AppColors.black,
                        ),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(iconProjectLocation),
                  SizedBox(
                    width: DEVICE_WIDTH * 0.01,
                  ),
                  MadaText(
                    '$city - $community',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(
                            AppColors.gray2,
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.01,
          ),
          if (priceStarts != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                MadaText(
                  '${getFormattedPrice(priceStarts!.toDouble())} ${getCurrency()}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(AppColors.primary),
                      ),
                ),
                if (showPriceText)
                  MadaText(
                    priceText ??
                        FFLocalizations.of(context).getText('price_starts'),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(
                            AppColors.gray2,
                          ),
                        ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
