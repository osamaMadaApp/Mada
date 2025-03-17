import '../../general_exports.dart';

class BedBathFilterSheet extends StatelessWidget {
  const BedBathFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenModel>(
      builder: (BuildContext context, SearchScreenModel model, Widget? child) {
        bool isFilterApplied = false;
        return PopScope(
          onPopInvoked: (pop) {
            if (!isFilterApplied) {
              model.selectedRoomNumber = model.tempRoomsNumber;
              model.selectedBathroomNumber = model.tempBathroomsNumber;
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
                          FFLocalizations.of(context).getText('bedrooms'),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        SelectList(
                          items: model.roomsNumber,
                          selectedItem: model.selectedRoomNumber,
                          onTap: model.onRoomNumberSelected,
                          borderColor: const Color(AppColors.green2),
                          borderWidth: 1,
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.04),
                        Text(
                          FFLocalizations.of(context).getText('bathrooms'),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        SelectList(
                          items: model.bathroomsNumber,
                          selectedItem: model.selectedBathroomNumber,
                          onTap: model.onBathroomNumberSelected,
                          borderColor: const Color(AppColors.green2),
                          borderWidth: 1,
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.04),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: FFLocalizations.of(context).getText('apply_filter'),
                    onPressed: () {
                      isFilterApplied = true;
                      if (model.selectedRoomNumber.isNotEmpty ||
                          model.selectedBathroomNumber.isNotEmpty) {
                        model.setSelectedItems(
                          model.filterProcess[4],
                        );
                      } else {
                        model.setSelectedItems(
                          model.filterProcess[4],
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
