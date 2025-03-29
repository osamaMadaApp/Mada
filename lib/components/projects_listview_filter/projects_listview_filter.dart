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
                            SelectListBottomList(
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
                            SelectListBottomList(
                              isProjectList: true,
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
                    SelectListBottomList(
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
                          SelectListBottomList(
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
                          SelectListBottomList(
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
                            SelectListBottomList(
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
                            SelectListBottomList(
                              items: controller.realEstateDevelopers,
                              selectedItem:
                                  controller.selectedTempRealEstateDeveloper,
                              isProjectList: true,
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

class SelectListBottomList extends StatelessWidget {
  const SelectListBottomList({
    required this.items,
    this.minHeight,
    this.minWidth,
    this.textKey = keyValue,
    this.selectedItem,
    this.onTap,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.defaultBorderColor = Colors.transparent,
    this.unselectedBackgroundColor,
    this.unselectedFontColor = Colors.black,
    super.key,
    this.spaceBetween = false,
    this.textWidth,
    this.borderRadius = 32,
    this.suffix,
    this.isWrap = false,
    this.showImage = true,
    this.scrollController,
    this.withLimitation = false,
    this.keys,
    this.showCount = false,
    this.suffixWidget,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.isProjectList,
  });

  final List<dynamic> items;
  final String textKey;
  final Function? onTap;
  final dynamic selectedItem;
  final double borderWidth;
  final bool showImage;
  final bool withLimitation;
  final bool? isProjectList;

  /// The border color of the selected item.
  final Color borderColor;

  /// The default border color of the item.
  final Color defaultBorderColor;
  final Color? unselectedBackgroundColor;
  final Color unselectedFontColor;
  final double? minHeight;
  final double? minWidth;
  final bool spaceBetween;
  final double? textWidth;
  final double borderRadius;
  final Widget? suffix;
  final bool isWrap;
  final ScrollController? scrollController;
  final List<GlobalKey>? keys;
  final bool showCount;
  final Widget? suffixWidget;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return isWrap
        ? Wrap(
            children: [
              if (withLimitation)
                ..._buildItemWithLimitation(
                  items,
                  context,
                  isWrap,
                  showImage,
                  showCount ? 7 : 14,
                )
              else
                ..._buildItem(items, context, isWrap, showImage),
            ],
          )
        : SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (withLimitation)
                  ..._buildItemWithLimitation(
                    items,
                    context,
                    isWrap,
                    showImage,
                    showCount ? 7 : 14,
                  )
                else
                  ..._buildItem(items, context, isWrap, showImage),
                if (suffixWidget != null) suffixWidget!,
              ],
            ),
          );
  }

  List<Widget> _buildItem(
    dynamic item,
    BuildContext context,
    bool isWrap,
    bool showImage,
  ) {
    return items.map(
      (dynamic item) {
        final bool isSelected = selectedItem is List
            ? selectedItem.any((element) => areMapsEqual(element, item))
            : (selectedItem == item || areMapsEqual(selectedItem, item));
        return (item[keyImage] != null && showImage)
            ? Container(
                margin: isProjectList == true
                    ? EdgeInsets.only(right: 20.w)
                    : EdgeInsets.zero,
                child: RoundedContainer(
                  minWidth: isProjectList == true ? 140 : null,
                  borderRadius: borderRadius ?? 0.1,
                  borderColor: isSelected ? borderColor : defaultBorderColor,
                  color: isSelected
                      ? FlutterMadaTheme.of(context)
                          .color97BE5A
                          .withOpacity(0.15)
                      : (unselectedBackgroundColor ??
                              FlutterMadaTheme.of(context).colorD2D2D240)
                          .withOpacity(0.25),
                  onTap: () {
                    onTap?.call(item);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CachedImage(
                        image: item[keyImage],
                        height: DEVICE_HEIGHT * 0.0525,
                        borderRadius: DEVICE_WIDTH * 0.01,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        item is String ? item : item[textKey] ?? '',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: isSelected
                                ? FlutterMadaTheme.of(context).color000000
                                : unselectedFontColor,
                            fontFamily: AppFonts.workSans,
                            fontSize: 14,
                            fontWeight: AppFonts.w400),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                key: keys != null ? keys![items.indexOf(item)] : null,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RoundedContainer(
                        borderRadius: borderRadius ?? 0.1,
                        borderWidth: borderWidth,
                        minHeight: minHeight ?? DEVICE_HEIGHT * 0.0001,
                        minWidth: minWidth,
                        borderColor:
                            isSelected ? borderColor : defaultBorderColor,
                        color: isSelected
                            ? FlutterMadaTheme.of(context)
                                .color97BE5A
                                .withOpacity(0.15)
                            : (unselectedBackgroundColor ??
                                    FlutterMadaTheme.of(context).colorD2D2D2)
                                .withOpacity(0.25),
                        onTap: () {
                          onTap?.call(item);
                        },
                        child: Column(
                          mainAxisAlignment:
                              mainAxisAlignment ?? MainAxisAlignment.center,
                          crossAxisAlignment:
                              crossAxisAlignment ?? CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: textWidth,
                                    child: Text(
                                      item is String
                                          ? item
                                          : item[textKey] ?? '',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: isSelected
                                                  ? FlutterMadaTheme.of(context)
                                                      .color000000
                                                  : unselectedFontColor,
                                              fontFamily: AppFonts.workSans,
                                              fontSize: 14,
                                              fontWeight: AppFonts.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (suffix != null) suffix!,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: DEVICE_WIDTH * 0.01),
                    ],
                  ),
                  if (isWrap) SizedBox(height: DEVICE_WIDTH * 0.03),
                ],
              );
      },
    ).toList();
  }

  List<Widget> _buildItemWithLimitation(dynamic item, BuildContext context,
      bool isWrap, bool showImage, int maxTextLength) {
    final List<Widget> rows = [];
    int itemsPerRow;

    for (int i = 0; i < items.length;) {
      // Determine the number of items per row based on the length of the text
      itemsPerRow = 3; // Default to 3 items per row
      for (int j = 0; j < 3 && i + j < items.length; j++) {
        final dynamic item = items[i + j];
        if (item[textKey] != null &&
            item[textKey].toString().length > maxTextLength) {
          itemsPerRow = 2; // If any item's text is too long, limit to 2 items
          break;
        }
      }

      rows.add(
        Row(
          children: List<Widget>.generate(itemsPerRow, (index) {
            if (i + index < items.length) {
              final dynamic item = items[i + index];
              final bool isSelected = selectedItem is List
                  ? selectedItem.contains(item)
                  : (selectedItem == item || areMapsEqual(selectedItem, item));
              return Column(
                key: keys != null ? keys![items.indexOf(item)] : null,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      RoundedContainer(
                        borderRadius: borderRadius,
                        borderWidth: borderWidth,
                        minHeight: minHeight ?? DEVICE_HEIGHT * 0.0001,
                        minWidth: minWidth,
                        borderColor:
                            isSelected ? borderColor : defaultBorderColor,
                        color: isSelected
                            ? FlutterMadaTheme.of(context)
                                .color97BE5A
                                .withOpacity(0.15)
                            : (unselectedBackgroundColor ??
                                    FlutterMadaTheme.of(context).colorD2D2D2)
                                .withOpacity(0.25),
                        onTap: () {
                          onTap?.call(item);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (item[keyImage] != null && showImage)
                              CachedImage(
                                image: item[keyImage],
                                width: DEVICE_WIDTH * 0.09,
                                height: DEVICE_HEIGHT * 0.0525,
                                borderRadius: DEVICE_WIDTH * 0.01,
                                fit: BoxFit.contain,
                              ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    spaceBetween ? DEVICE_WIDTH * 0.075 : 0,
                              ),
                              child: Align(
                                child: SizedBox(
                                  width: textWidth,
                                  child: Row(
                                    children: [
                                      Text(
                                        item is String
                                            ? item
                                            : item[textKey] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: isSelected
                                                  ? FlutterMadaTheme.of(context)
                                                      .color000000
                                                  : unselectedFontColor,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      if (item['propertyCount'] != null &&
                                          showCount)
                                        Text(' ( ${item['propertyCount']} )'),
                                      if (suffix != null) suffix!,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: DEVICE_WIDTH * 0.01),
                    ],
                  ),
                  if (isWrap) SizedBox(height: DEVICE_WIDTH * 0.03),
                ],
              );
            } else {
              return Expanded(child: Container());
            }
          }),
        ),
      );

      rows.add(SizedBox(height: DEVICE_WIDTH * 0.03));
      i += itemsPerRow;
    }

    return rows;
  }
}
