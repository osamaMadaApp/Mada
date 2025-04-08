import '../../app_state.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../general_exports.dart';

class ProjectUnitsListviewFilterSheet extends StatelessWidget {
  const ProjectUnitsListviewFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic masterData = FFAppState().masterDateJsonModel;
    return Consumer<ProjectUnitsListviewModel>(
      builder: (
        BuildContext context,
        ProjectUnitsListviewModel model,
        Widget? child,
      ) =>
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              FFLocalizations.of(context).getText('floors'),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            SelectList(
              items: model.floors,
              selectedItem: model.selectedTemFloor,
              onTap: model.onFloorPress,
              borderColor: const Color(AppColors.green2),
              borderWidth: 1,
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              FFLocalizations.of(context).getText('bedrooms'),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            SelectList(
              items: model.roomsNumber,
              selectedItem: model.selectedTemRoomsNumber,
              onTap: model.onRoomsNumberPress,
              borderColor: const Color(AppColors.green2),
              borderWidth: 1,
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              FFLocalizations.of(context).getText('bathrooms'),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            SelectList(
              items: model.bathroomsNumber,
              selectedItem: model.selectedTemBathroomsNumber,
              onTap: model.onBathroomsNumberPress,
              borderColor: const Color(AppColors.green2),
              borderWidth: 1,
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              FFLocalizations.of(context).getText('price_range'),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            RangeSlider(
              values: model.priceTemRange!,
              onChanged: model.onPriceRangeSliderChange,
              min: model.minTemPrice.toDouble(),
              max: model.maxTemPrice.toDouble(),
              labels: formattedRangeLabels(
                model.priceTemRange!,
                suffix: getCurrency(),
                price: true,
              ),
              divisions: masterData[keyBuyPriceDivision],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: DEVICE_HEIGHT * 0.008),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText('min'),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(
                              AppColors.black,
                            ),
                          ),
                        ),
                        CustomInput(
                          focusNode: model.minPriceFocusNode,
                          controller: model.minPriceController,
                          keyboardType: TextInputType.number,
                          hint: getFormattedPrice(
                            model.minPrice.toDouble(),
                          ),
                          hintStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(AppColors.gray2),
                          ),
                          onChange: model.onMinPriceTextChange,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
                        width: 22.w,
                        color:FlutterMadaTheme.of(context).colorE1E1E1,
                        height: 1,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText('max'),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: const Color(
                              AppColors.black,
                            ),
                          ),
                        ),
                        CustomInput(
                          focusNode: model.maxPriceFocusNode,
                          controller: model.maxPriceController,
                          keyboardType: TextInputType.number,
                          hint: getFormattedPrice(
                            model.maxPrice.toDouble(),
                          ),
                          hintStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(AppColors.gray2),
                          ),
                          onChange: model.onMaxPriceTextChange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              FFLocalizations.of(context).getText('area'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            RangeSlider(
              values: model.spaceTemRange!,
              onChanged: model.onSpaceRangeSliderChange,
              min: model.minTemSpace.toDouble(),
              max: model.maxTemSpace.toDouble(),
              labels: formattedRangeLabels(
                model.spaceTemRange!,
                suffix: getUnitOfMeasure(context),
              ),
              divisions: masterData[keyAreaDivision],
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText('min'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(
                                AppColors.black,
                              ),
                            ),
                      ),
                      CustomInput(
                        focusNode: model.minAreaFocusNode,
                        controller: model.minAreaController,
                        keyboardType: TextInputType.number,
                        hint: getFormattedPrice(
                          model.minSpace.toDouble(),
                        ),
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: const Color(AppColors.gray2),
                                ),
                        onChange: model.onMinAreaTextChange,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
                      width: 22.w,
                      color:FlutterMadaTheme.of(context).colorE1E1E1,
                      height: 1,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText('max'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(AppColors.black),
                            ),
                      ),
                      CustomInput(
                        focusNode: model.maxAreaFocusNode,
                        controller: model.maxAreaController,
                        keyboardType: TextInputType.number,
                        hint: getFormattedPrice(
                          model.maxSpace.toDouble(),
                        ),
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: const Color(AppColors.gray2),
                                ),
                        onChange: model.onMaxAreaTextChange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            CustomButton(
              text: FFLocalizations.of(context).getText('apply_filter'),
              onPressed: () {
                model.onApplyFilterPress(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
