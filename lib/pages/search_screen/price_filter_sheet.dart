import '../../app_state.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../general_exports.dart';

class PriceFilterSheet extends StatelessWidget {
  const PriceFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenModel>(
      builder: (BuildContext context, SearchScreenModel model, Widget? child) {
        bool isFilterApplied = false;
        return PopScope(
          onPopInvoked: (pop) {
            if (!isFilterApplied) {
              model.priceRange = RangeValues(
                model.tempMinPrice.toDouble(),
                model.tempMaxPrice.toDouble(),
              );
              model.minPriceController.text = getFormattedPrice(
                model.tempMinPrice.toDouble(),
              );
              model.maxPriceController.text = getFormattedPrice(
                model.tempMaxPrice.toDouble(),
              );
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(FFLocalizations.of(context).getText('price')),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        RangeSlider(
                          values: model.priceRange!,
                          onChanged: model.onPriceRangeSliderChange,
                          min: model.minPrice,
                          max: model.maxPrice,
                          labels: formattedRangeLabels(
                            model.priceRange!,
                            suffix: getCurrency(),
                            price: true,
                          ),
                          divisions: FFAppState().masterDateJsonModel[
                              model.selectedCategories[keySlug] == 'buy'
                                  ? keyBuyPriceDivision
                                  : keyRentPriceDivision],
                        ),
                        Column(
                          children: [
                            SizedBox(height: DEVICE_HEIGHT * 0.01),
                            Row(
                              children: [
                                Text(
                                  '${FFLocalizations.of(context).getText('min_price')}: ${getFormattedPrice(model.minPrice)} ${getCurrency()}',
                                ),
                                const Spacer(),
                                Text(
                                  '${FFLocalizations.of(context).getText('max_price')}: ${getFormattedPrice(model.maxPrice)} ${getCurrency()}',
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_WIDTH * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomInput(
                                        focusNode: model.minPriceFocusNode,
                                        controller: model.minPriceController,
                                        keyboardType: TextInputType.number,
                                        prefixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${FFLocalizations.of(context).getText('min')}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.black,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getCurrency(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.gray2,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        hint: getFormattedPrice(
                                          model.minPrice.toDouble(),
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color:
                                                  const Color(AppColors.gray2),
                                            ),
                                        onChange: model.onMinPriceTextChange,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.005),
                                Container(
                                  height: 4.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    color: const Color(AppColors.gray6),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.005),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomInput(
                                        focusNode: model.maxPriceFocusNode,
                                        controller: model.maxPriceController,
                                        keyboardType: TextInputType.number,
                                        hint: getFormattedPrice(
                                          model.maxPrice.toDouble(),
                                        ),
                                        prefixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${FFLocalizations.of(context).getText('max')}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.black,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getCurrency(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.gray2,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color:
                                                  const Color(AppColors.gray2),
                                            ),
                                        onChange: model.onMaxPriceTextChange,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                          ],
                        )
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

                      if (model.priceRange!.start !=
                              FFAppState()
                                      .masterDateJsonModel[keyPriceRangeFilter]
                                  [0] ||
                          model.priceRange!.end !=
                              FFAppState()
                                      .masterDateJsonModel[keyPriceRangeFilter]
                                  [1]) {
                        model.setSelectedItems(
                          model.filterProcess[2],
                        );
                      } else {
                        model.setSelectedItems(
                          model.filterProcess[2],
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

class AreaFilterSheet extends StatelessWidget {
  const AreaFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenModel>(
      builder: (BuildContext context, SearchScreenModel model, Widget? child) {
        bool isFilterApplied = false;
        return PopScope(
          onPopInvoked: (pop) {
            if (!isFilterApplied) {
              model.areaRange = RangeValues(
                model.tempMinArea.toDouble(),
                model.tempMaxArea.toDouble(),
              );
              model.minAreaController.text = getFormattedPrice(
                model.tempMinArea.toDouble(),
              );
              model.maxAreaController.text = getFormattedPrice(
                model.tempMaxArea.toDouble(),
              );
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(FFLocalizations.of(context).getText('range')),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        RangeSlider(
                          values: model.areaRange!,
                          onChanged: model.onAreaFilterChange,
                          min: model.minArea.toDouble(),
                          max: model.maxArea.toDouble(),
                          labels: formattedRangeLabels(
                            model.areaRange!,
                            suffix: getUnitOfMeasure(context),
                          ),
                          divisions:
                              FFAppState().masterDateJsonModel[keyAreaDivision],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                        Column(
                          children: [
                            SizedBox(height: DEVICE_HEIGHT * 0.01),
                            Row(
                              children: [
                                Text(
                                  '${FFLocalizations.of(context).getText('min_area')}: ${getFormattedPrice(model.minArea)} m²',
                                ),
                                const Spacer(),
                                Text(
                                  '${FFLocalizations.of(context).getText('max_area')}: ${getFormattedPrice(model.maxArea)} m²',
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_WIDTH * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomInput(
                                        focusNode: model.minAreaFocusNode,
                                        controller: model.minAreaController,
                                        keyboardType: TextInputType.number,
                                        hint: getFormattedPrice(
                                          model.minArea.toDouble(),
                                        ),
                                        prefixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${FFLocalizations.of(context).getText('min')}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.black,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getUnitOfMeasure(context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.gray2,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color:
                                                  const Color(AppColors.gray2),
                                            ),
                                        onChange: model.onMinAreaTextChange,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.005),
                                Container(
                                  height: 4.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    color: const Color(AppColors.gray6),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.005),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomInput(
                                        focusNode: model.maxAreaFocusNode,
                                        controller: model.maxAreaController,
                                        keyboardType: TextInputType.number,
                                        hint: getFormattedPrice(
                                          model.maxArea.toDouble(),
                                        ),
                                        prefixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${FFLocalizations.of(context).getText('max')}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.black,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getUnitOfMeasure(context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      AppColors.gray2,
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color:
                                                  const Color(AppColors.gray2),
                                            ),
                                        onChange: model.onMaxAreaTextChange,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                          ],
                        )
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

                      if (model.areaRange!.start !=
                              FFAppState()
                                  .masterDateJsonModel[keyAreaRangeFilter][0] ||
                          model.areaRange!.end !=
                              FFAppState()
                                  .masterDateJsonModel[keyAreaRangeFilter][1]) {
                        model.setSelectedItems(
                          model.filterProcess[3],
                        );
                      } else {
                        model.setSelectedItems(
                          model.filterProcess[3],
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
