import '../../general_exports.dart';

class LocationAndNearbyPlaces extends StatelessWidget {
  const LocationAndNearbyPlaces({
    required this.nearbyLocations,
    super.key,
    this.viewProjectOnMap = true,
    this.viewProjectText,
    this.viewOnMap,
    this.title,
    this.showGrayLine = false,
  });

  final List<dynamic> nearbyLocations;
  final bool viewProjectOnMap;
  final String? viewProjectText;
  final String? title;
  final Function()? viewOnMap;
  final bool showGrayLine;

  @override
  Widget build(BuildContext context) {
    return (nearbyLocations.isNotEmpty || viewProjectOnMap)
        ? Column(
            children: [
              if (showGrayLine)
                Padding(
                  padding: EdgeInsets.only(
                    top: DEVICE_HEIGHT * 0.02,
                  ),
                  child: const GrayLine(),
                ),
              Padding(
                padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (nearbyLocations.isNotEmpty)
                      Column(
                        children: [
                          MadaText(
                            FFLocalizations.of(context)
                                .getText('nearby_places'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(
                                    AppColors.black,
                                  ),
                                ),
                          ),
                          SizedBox(
                            height: DEVICE_HEIGHT * 0.02,
                          ),
                        ],
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nearbyLocations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextWithValue(
                          text: nearbyLocations[index][keyName],
                          value: nearbyLocations[index][keyDistance],
                          color: index.isOdd
                              ? const Color(AppColors.primary)
                                  .withValues(alpha: 0.1)
                              : const Color(AppColors.white),
                        );
                      },
                    ),
                    if (viewProjectOnMap)
                      Column(
                        children: [
                          SizedBox(
                            height: DEVICE_HEIGHT * 0.02,
                          ),
                          MadaText(
                            title ?? FFLocalizations.of(context).getText('location'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(
                                    AppColors.black,
                                  ),
                                ),
                          ),
                          SizedBox(
                            height: DEVICE_HEIGHT * 0.02,
                          ),
                        ],
                      ),
                    if (viewProjectOnMap)
                      GestureDetector(
                        onTap: viewOnMap,
                        child: Container(
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(DEVICE_HEIGHT * 0.01),
                            color: const Color(AppColors.gray5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              DEVICE_HEIGHT * 0.02,
                            ),
                            child: Column(
                              spacing: 20.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(iconViewOnMap),
                                MadaText(
                                  viewProjectText ??
                                      FFLocalizations.of(context)
                                          .getText('view_project_on_map'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: const Color(
                                          AppColors.black,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )
        : const Center();
  }
}
