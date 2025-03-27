import '../../backend/schema/util/schema_util.dart';
import '../../general_exports.dart';
import '../../pages/projects_listview/projects_listview_model.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import '../../utils/colors.dart';
import '../select_list/mada_select_list.dart';

class ProjectListviewFilterSheet extends StatelessWidget {
  const ProjectListviewFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProjectsListviewModel>(context);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 177.h, 24.w, 32.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.projectStatus != 'Lands')
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: DEVICE_HEIGHT * 0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('purpose_of_use'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 16,
                                    fontFamily: AppFonts.outfit,
                                    fontWeight: AppFonts.w500,
                                  ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                            SelectList(
                              isWrap: true,
                              items: controller.filteredPropertyPurpose,
                              selectedItem:
                                  controller.selectedTemFilteredPropertyPurpose,
                              onTap: controller
                                  .onTempFilteredPropertyPurposePressed,
                              borderColor:
                                  FlutterMadaTheme.of(context).color97BE5A,
                              unselectedBackgroundColor:
                                  FlutterMadaTheme.of(context)
                                      .colorD2D2D2
                                      .withOpacity(
                                        0.25,
                                      ),
                              borderWidth: 1,
                              borderRadius: 22,
                            ),
                          ],
                        ),
                      ),
                    if (controller.projectStatus == 'ready')
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: DEVICE_HEIGHT * 0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('project_categories'),
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
                              items: controller.projectCategories,
                              selectedItem:
                                  controller.selectedTemProjectsCategories,
                              onTap: controller.onTempProjectCategoriesPressed,
                              borderColor:
                                  FlutterMadaTheme.of(context).color97BE5A,
                              textKey: keyName,
                              unselectedBackgroundColor:
                                  FlutterMadaTheme.of(context)
                                      .colorD2D2D2
                                      .withOpacity(
                                        0.25,
                                      ),
                              borderWidth: 1,
                              borderRadius: 22,
                            ),
                          ],
                        ),
                      ),
                    Text(
                      FFLocalizations.of(context).getText('please_select_city'),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                    SelectList(
                      items: controller.cities,
                      textKey: keyName,
                      selectedItem: controller.selectedTempCity,
                      onTap: controller.onSelectTempCity,
                      borderColor: FlutterMadaTheme.of(context).color97BE5A,
                      borderWidth: 1,
                      borderRadius: 22,
                      unselectedBackgroundColor:
                          FlutterMadaTheme.of(context).colorD2D2D2.withOpacity(
                                0.25,
                              ),
                    ),
                    Visibility(
                      visible: controller.neighborhoods.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: DEVICE_HEIGHT * 0.03),
                          Text(
                            FFLocalizations.of(context)
                                .getText('the_neighborhood'),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                          SelectList(
                            items: controller.neighborhoods,
                            selectedItem: controller.selectedTempNeighborhood,
                            textKey: keyName,
                            onTap: controller.onTempNeighborhoodPress,
                            borderColor:
                                FlutterMadaTheme.of(context).color97BE5A,
                            unselectedBackgroundColor:
                                FlutterMadaTheme.of(context)
                                    .colorD2D2D2
                                    .withOpacity(
                                      0.25,
                                    ),
                            borderWidth: 1,
                            borderRadius: 22,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.03),
                    Visibility(
                      visible: controller.subCommunities.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            items: controller.subCommunities,
                            selectedItem: controller.selectedTemSubCommunity,
                            onTap: controller.onTempSubCommunityPress,
                            borderColor:
                                FlutterMadaTheme.of(context).color97BE5A,
                            unselectedBackgroundColor:
                                FlutterMadaTheme.of(context)
                                    .colorD2D2D2
                                    .withOpacity(
                                      0.25,
                                    ),
                            textKey: keyName,
                            borderWidth: 1,
                            borderRadius: 22,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                        ],
                      ),
                    ),
                    if (controller.projectStatus != 'Lands')
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: DEVICE_HEIGHT * 0.03,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText('bedrooms'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                            SelectList(
                              items: controller.roomsNumber,
                              selectedItem: controller.selectedTemRoomsNumber,
                              onTap: controller.onTemRoomsNumberPress,
                              borderColor:
                                  FlutterMadaTheme.of(context).color97BE5A,
                              unselectedBackgroundColor:
                                  FlutterMadaTheme.of(context)
                                      .colorD2D2D2
                                      .withOpacity(
                                        0.25,
                                      ),
                              borderWidth: 1,
                              borderRadius: 22,
                            ),
                          ],
                        ),
                      ),
                    Text(
                      FFLocalizations.of(context).getText('price'),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.01),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData().copyWith(
                    activeTrackColor: Color(AppColors.green),
                    inactiveTrackColor: Color(AppColors.gray2),
                    thumbColor: Color(AppColors.black),
                    overlayColor: Color(AppColors.transparent),
                    trackHeight: 2.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 35.0),
                    valueIndicatorColor: Color(AppColors.green3),
                    rangeValueIndicatorShape:
                        PaddleRangeSliderValueIndicatorShape(),
                    overlappingShapeStrokeColor: Color(AppColors.black),
                  ),
                  child: RangeSlider(
                    values: controller.priceTemRange!,
                    onChanged: controller.onPriceRangeSliderChange,
                    min: controller.minPrice.toDouble(),
                    max: controller.maxPrice.toDouble(),
                    labels: formattedRangeLabels(
                      controller.priceTemRange!,
                      suffix: getCurrency(),
                      price: true,
                    ),
                    divisions:
                        FFAppState().masterDateJsonModel[keyBuyPriceDivision],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: DEVICE_HEIGHT * 0.04),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText('min'),
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
                              ),
                              CustomInput(
                                focusNode: controller.minPriceFocusNode,
                                controller: controller.minPriceController,
                                keyboardType: TextInputType.number,
                                hint: getFormattedPrice(
                                  controller.minPrice.toDouble(),
                                ),
                                textInputAction: TextInputAction.done,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Color(AppColors.gray2),
                                    ),
                                onChange: controller.onMinPriceTextChange,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 22.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText('max'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: const Color(
                                        AppColors.black,
                                      ),
                                    ),
                              ),
                              CustomInput(
                                focusNode: controller.maxPriceFocusNode,
                                controller: controller.maxPriceController,
                                keyboardType: TextInputType.number,
                                hint: getFormattedPrice(
                                  controller.maxPrice.toDouble(),
                                ),
                                textInputAction: TextInputAction.done,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Color(AppColors.gray2),
                                    ),
                                onChange: controller.onMaxPriceTextChange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.03),
                    Text(
                      FFLocalizations.of(context).getText('area'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.01),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData().copyWith(
                    activeTrackColor: Color(AppColors.green),
                    inactiveTrackColor: Color(AppColors.gray2),
                    thumbColor: Color(AppColors.black),
                    overlayColor: Color(AppColors.transparent),
                    trackHeight: 2.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 35.0),
                    valueIndicatorColor: Color(AppColors.green3),
                    rangeValueIndicatorShape:
                        PaddleRangeSliderValueIndicatorShape(),
                    overlappingShapeStrokeColor: Color(AppColors.black),
                  ),
                  child: RangeSlider(
                    values: controller.spaceTemRange!,
                    onChanged: controller.onSpaceRangeSliderChange,
                    min: controller.minSpace.toDouble(),
                    max: controller.maxSpace.toDouble(),
                    labels: formattedRangeLabels(
                      controller.spaceTemRange!,
                      suffix: getUnitOfMeasure(context),
                    ),
                    divisions:
                        FFAppState().masterDateJsonModel[keyAreaDivision],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: DEVICE_HEIGHT * 0.04),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText('min'),
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
                              ),
                              CustomInput(
                                focusNode: controller.minAreaFocusNode,
                                controller: controller.minAreaController,
                                keyboardType: TextInputType.number,
                                hint: getFormattedPrice(
                                  controller.minSpace.toDouble(),
                                ),
                                textInputAction: TextInputAction.done,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Color(AppColors.gray2),
                                    ),
                                onChange: controller.onMinAreaTextChange,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 22.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText('max'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(AppColors.black),
                                    ),
                              ),
                              CustomInput(
                                focusNode: controller.maxAreaFocusNode,
                                controller: controller.maxAreaController,
                                keyboardType: TextInputType.number,
                                hint: getFormattedPrice(
                                  controller.maxSpace.toDouble(),
                                ),
                                textInputAction: TextInputAction.done,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Color(AppColors.gray2),
                                    ),
                                onChange: controller.onMaxAreaTextChange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.04),
                    if (controller.projectStatus != 'Lands')
                      Padding(
                        padding: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('real_estate_developer'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                            SelectList(
                              items: controller.realEstateDevelopers,
                              selectedItem:
                                  controller.selectedTempRealEstateDeveloper,
                              onTap: controller.onTempRealEstateDeveloperPress,
                              borderColor: const Color(AppColors.green2),
                              textKey: keyName,
                              unselectedBackgroundColor:
                                  FlutterMadaTheme.of(context)
                                      .colorD2D2D2
                                      .withOpacity(0.25),
                              borderWidth: 1,
                              borderRadius: 8,
                              minWidth: DEVICE_WIDTH * 0.3,
                              minHeight: 0.2,
                              textWidth: DEVICE_WIDTH * 0.3,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ],
                        ),
                      ),
                    // GestureDetector(
                    //   onTap: controller.onShowAvailableUnitsToggled,
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(vertical: DEVICE_WIDTH * 0.04),
                    //     child: Row(
                    //       children: <Widget>[
                    //         SvgPicture.asset(
                    //           controller.showAvailableUnits
                    //               ? iconCheckboxChecked
                    //               : iconCheckboxUnChecked,
                    //           width: DEVICE_WIDTH * 0.05,
                    //           height: DEVICE_WIDTH * 0.05,
                    //         ),
                    //         SizedBox(width: DEVICE_WIDTH * 0.04),
                    //         Text(
                    //           'show_available_projects_only'.tr,
                    //           style: Theme.of(context).textTheme.bodyMedium!,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: DEVICE_WIDTH,
                      child: CustomButton(
                        text:
                            FFLocalizations.of(context).getText('apply_filter'),
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Color(AppColors.white),
                                ),
                        onPressed: () {
                          controller.onApplyFilterPress();
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        iconAix,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    FFLocalizations.of(context).getText('custom_filter'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          fontFamily: AppFonts.outfit,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
