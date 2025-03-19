import '../../general_exports.dart';

class RegulatoryInformation extends StatelessWidget {
  const RegulatoryInformation({
    required this.regularlyInfo,
    required this.locations,
    required this.propertySpec,
    super.key,
    this.regaInfo,
  });
  final List<dynamic> regularlyInfo;
  final List<dynamic> locations;
  final List<dynamic> propertySpec;
  final dynamic regaInfo;

  @override
  Widget build(BuildContext context) {
    return regularlyInfo.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MadaText(
                    FFLocalizations.of(context)
                        .getText('regulatory_information'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: const Color(
                            AppColors.black,
                          ),
                        ),
                  ),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.02,
                  ),
                  ListView.builder(
                    itemCount: regularlyInfo.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return TextWithValue(
                        text: regularlyInfo[index][keyLabel] ?? '',
                        value: regularlyInfo[index][keyValue] ?? '',
                        color: index.isOdd
                            ? const Color(AppColors.white)
                            : const Color(AppColors.primary).withOpacity(0.1),
                      );
                    },
                  ),
                  if (locations.isNotEmpty || propertySpec.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        top: DEVICE_HEIGHT * 0.02,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          SideSheet.show(
                            context,
                            child: RegaSheet(
                              locations: locations,
                              propertySpec: propertySpec,
                              regaInfo: regaInfo,
                            ),
                            title: FFLocalizations.of(context)
                                .getText('regulatory_information'),
                          );
                        },
                        child: Container(
                          width: DEVICE_WIDTH * 0.06,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: MadaText(
                            FFLocalizations.of(context).getText('see_more'),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(
                                        AppColors.green,
                                      ),
                                      color: const Color(
                                        AppColors.green,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
            ],
          )
        : const Center();
  }
}

class RegaSheet extends StatelessWidget {
  const RegaSheet({
    required this.locations,
    required this.propertySpec,
    super.key,
    this.regaInfo,
  });

  final List<dynamic> locations;
  final List<dynamic> propertySpec;
  final dynamic regaInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (locations.isNotEmpty)
          MadaText(
            FFLocalizations.of(context).getText('location'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(
                    AppColors.black,
                  ),
                ),
          ),
        SizedBox(
          height: DEVICE_HEIGHT * 0.02,
        ),
        ListView.builder(
          itemCount: locations.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return TextWithValue(
              text: locations[index][keyLabel] ?? '',
              value: locations[index][keyValue].toString(),
              color: index.isOdd
                  ? const Color(AppColors.white)
                  : const Color(AppColors.primary).withOpacity(0.1),
            );
          },
        ),
        SizedBox(
          height: DEVICE_HEIGHT * 0.02,
        ),
        if (propertySpec.isNotEmpty)
          MadaText(
            FFLocalizations.of(context).getText('property_specification'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(
                    AppColors.black,
                  ),
                ),
          ),
        SizedBox(
          height: DEVICE_HEIGHT * 0.02,
        ),
        ListView.builder(
          itemCount: propertySpec.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return TextWithValue(
              text: propertySpec[index][keyLabel] ?? '',
              value: propertySpec[index][keyValue].toString(),
              color: index.isOdd
                  ? const Color(AppColors.white)
                  : const Color(AppColors.primary).withOpacity(0.1),
            );
          },
        ),
        // REGA QR CODE
        if (regaInfo[keyQrUrl] != null && regaInfo[keyQrUrl].isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
              MadaText(
                FFLocalizations.of(context).getText('view_details_on_rega'),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(
                        AppColors.black,
                      ),
                    ),
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
              SizedBox(
                width: DEVICE_WIDTH,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DEVICE_HEIGHT * 0.005,
                      ),
                      child: QrImageView(
                        data: regaInfo[keyQrUrl] ?? '',
                        size: DEVICE_HEIGHT * 0.17,
                        gapless: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
            ],
          ),
      ],
    );
  }
}
