import '../../general_exports.dart';

class PropertyTypeFilterSheet extends StatelessWidget {
  const PropertyTypeFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenModel>(
      builder: (BuildContext context, SearchScreenModel model, Widget? child) {
        bool isFilterApplied = false;
        return PopScope(
          onPopInvoked: (pop) {
            if (!isFilterApplied) {
              model.selectedPurposeOfUse = model.tempPurposeOfUse;
              model.selectedTypeOfProperty = model.tempTypeOfProperty;
              model.selectedCategories = model.tempCategories;
              // model.update();
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        FFLocalizations.of(context).getText('categories'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.03),
                      SelectList(
                        isWrap: true,
                        items: model.categories,
                        selectedItem: model.selectedCategories,
                        onTap: model.onCategoryPress,
                        textKey: keyName,
                        borderColor: const Color(AppColors.green2),
                        borderWidth: 1,
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      Text(
                        FFLocalizations.of(context).getText('purpose_of_use'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      SelectList(
                        isWrap: true,
                        items: model.purposeOfUse,
                        selectedItem: model.selectedPurposeOfUse,
                        onTap: model.onPurposeOfUseSelected,
                        borderColor: const Color(AppColors.green2),
                        borderWidth: 1,
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      if (model.typeOfProperty.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('type_of_property_looking_for'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                            SelectList(
                              isWrap: true,
                              items: model.typeOfProperty,
                              selectedItem: model.selectedTypeOfProperty,
                              onTap: model.onTypeOfPropertySelected,
                              borderColor: const Color(AppColors.green2),
                              textKey: keyName,
                              borderWidth: 1,
                              showCount: true,
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.04),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: DEVICE_WIDTH,
                  child: CustomButton(
                    text: FFLocalizations.of(context).getText('apply_filter'),
                    onPressed: () {
                      isFilterApplied = true;
                      if (model.selectedCategories.isNotEmpty ||
                          model.selectedPurposeOfUse.isNotEmpty ||
                          model.selectedTypeOfProperty.isNotEmpty) {
                        model.setSelectedItems(
                          model.filterProcess[1],
                        );
                      } else {
                        model.setSelectedItems(
                          model.filterProcess[1],
                          type: ListTypes.remove,
                        );
                      }
                      model.onApplyFilterPress(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
