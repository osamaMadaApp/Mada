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
    consoleLog(locations.isNotEmpty || regularlyInfo.isNotEmpty);
    return regularlyInfo.isNotEmpty
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
                child: Column(
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
                          color: index % 2 == 1
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
                            // Get.bottomSheet(
                            //   BottomSheetContainer(
                            //     child: RegaSheet(
                            //       locations: locations,
                            //       propertySpec: propertySpec,
                            //       regaInfo: regaInfo,
                            //     ),
                            //   ),
                            //   isScrollControlled: true,
                            // );
                          },
                          child: Container(
                            width: DEVICE_WIDTH * 0.2,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: MadaText(
                              FFLocalizations.of(context).getText('see_more'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
            ],
          )
        : const Center();
  }
}
