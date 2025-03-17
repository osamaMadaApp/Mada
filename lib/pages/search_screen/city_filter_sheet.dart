import '../../general_exports.dart';

class CityFilterSheet extends StatelessWidget {
  const CityFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFilterApplied = false;
    return Consumer<SearchScreenModel>(
      builder: (BuildContext context, SearchScreenModel model, Widget? child) {
        return PopScope(
          onPopInvoked: (pop) async {
            if (!isFilterApplied) {
              model.selectedCities = model.tempCities;
              model.selectedNeighborhoods = model.tempNeighborhoods;
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          FFLocalizations.of(context).getText('choose_city'),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        SelectList(
                          isWrap: true,
                          items: model.cities,
                          selectedItem: model.selectedCities,
                          onTap: model.onCityPress,
                          textKey: keyName,
                          borderColor: const Color(AppColors.green2),
                          borderWidth: 1,
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        if (model.communities.isNotEmpty)
                          Text(
                            FFLocalizations.of(context)
                                .getText('choose_community'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        SelectList(
                          isWrap: true,
                          items: model.communities,
                          selectedItem: model.selectedCommunities,
                          onTap: model.onCommunityPress,
                          borderColor: const Color(AppColors.green2),
                          textKey: keyName,
                          borderWidth: 1,
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        if (model.subCommunities.isNotEmpty)
                          Text(
                            FFLocalizations.of(context)
                                .getText('choose_sub_community'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        SelectList(
                          isWrap: true,
                          items: model.subCommunities,
                          selectedItem: model.selectedSubCommunities,
                          onTap: model.onSubCommunityPress,
                          borderColor: const Color(AppColors.green2),
                          textKey: keyName,
                          borderWidth: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: DEVICE_WIDTH,
                  child: CustomButton(
                    text: FFLocalizations.of(context).getText('apply_filter'),
                    onPressed: () {
                      isFilterApplied = true;

                      if (model.selectedCities.isNotEmpty ||
                          model.selectedNeighborhoods.isNotEmpty) {
                        model.setSelectedItems(
                          model.filterProcess[0],
                        );
                      } else {
                        model.setSelectedItems(
                          model.filterProcess[0],
                          type: ListTypes.remove,
                        );
                      }
                      model.onApplyFilterPress(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
