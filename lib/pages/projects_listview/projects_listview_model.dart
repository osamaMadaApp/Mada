import '../../app_state.dart';
import '../../components/bottom_sheet_container/bottom_sheet_container.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ProjectsListviewModel extends ChangeNotifier{
  


  List<dynamic> filteredPropertyPurpose =
  FFAppState().masterDateJsonModel[keyFilteredPropertyPurpose];
  // Only for ready projects
  List<dynamic> projectCategories =
  FFAppState().masterDateJsonModel[keyProjectCategories];

  dynamic roomsNumber = FFAppState().masterDateJsonModel[keyRooms];
  dynamic screenTitle ;
  dynamic projectStatus ;
  bool isCurrentLocationSelected = true;
  bool showAvailableUnits = true;
  List<dynamic> selectedTypeFilter = [];
  List<dynamic> selectedCity = [];
  List<dynamic> selectedTempCity = [];
  List<dynamic> selectedNeighborhood = [];
  List<dynamic> selectedTempNeighborhood = [];
  List<dynamic> selectedRealEstateDeveloper = [];
  List<dynamic> selectedTempRealEstateDeveloper = [];
  Map<String, dynamic> selectedFilteredPropertyPurpose = {};
  Map<String, dynamic> selectedProjectCategory = {};
  Map<String, dynamic> selectedTemFilteredPropertyPurpose = {};
  Map<String, dynamic> selectedTemProjectsCategories = {};
  List<dynamic> selectedRoomsNumber = [];
  List<dynamic> selectedTemRoomsNumber = [];
  List<dynamic> typeFilter = <dynamic>[];
  List<dynamic> cities = <dynamic>[];
  List<dynamic> neighborhoods = <dynamic>[];
  List<dynamic> realEstateDevelopers = <dynamic>[];
  bool isLoading = true;
  List<dynamic> projects = [];
  Map<String, dynamic> data = {};
  Map<String, dynamic> filterMap = <String, dynamic>{};
  RangeValues? priceRange;
  RangeValues? priceTemRange;
  RangeValues? spaceRange;
  RangeValues? spaceTemRange;
  dynamic minPrice = -1;
  dynamic minSpace = -1;
  dynamic maxPrice = -1;
  dynamic maxSpace = -1;
  dynamic selectedSortKey = {};
  dynamic selectedSortType = {};
  dynamic selectedTemSortKey = {};
  dynamic selectedTemSortType = {};
  ScrollController scrollController = ScrollController();
  // MyAppController myAppController = Get.find<MyAppController>();
  List<dynamic> subCommunities = [];
  List<dynamic> selectedSubCommunity = [];
  List<dynamic> selectedTemSubCommunity = [];
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  NumberFormat formatter = NumberFormat('###,###,###');
  TextEditingController minAreaController = TextEditingController();
  TextEditingController maxAreaController = TextEditingController();
  FocusNode minPriceFocusNode = FocusNode();
  FocusNode maxPriceFocusNode = FocusNode();
  FocusNode minAreaFocusNode = FocusNode();
  FocusNode maxAreaFocusNode = FocusNode();
  int page = 0;
  bool hasNextPage = true;
  int totalDocs = 0;


  void onInit(String keyTitle,String keyProjectStatus) {
    screenTitle = keyTitle;
    projectStatus = keyProjectStatus;
    minPrice = FFAppState().masterDateJsonModel['priceRangeFilterProject']
    [0] ??
        0;
    maxPrice = FFAppState().masterDateJsonModel['priceRangeFilterProject']
    [1] ??
        100000;
    minSpace = FFAppState().masterDateJsonModel['areaRangeFilterProject']
    [0] ??
        0;
    maxSpace = FFAppState().masterDateJsonModel['areaRangeFilterProject']
    [1] ??
        500;
    minPriceController.text = formatter.format(minPrice);
    maxPriceController.text = formatter.format(maxPrice);
    minAreaController.text = minSpace.toString();
    maxAreaController.text = maxSpace.toString();
    priceRange = RangeValues(
      minPrice.toDouble(),
      maxPrice.toDouble(),
    );
    spaceRange = RangeValues(
      minSpace.toDouble(),
      maxSpace.toDouble(),
    );

    priceTemRange = priceRange;
    spaceTemRange = spaceRange;
    minPriceFocusNode.addListener(() {
      minPriceController.text = formatter.format(priceTemRange!.start.toInt());
    });
    maxPriceFocusNode.addListener(() {
      maxPriceController.text = formatter.format(priceTemRange!.end.toInt());
    });
    minAreaFocusNode.addListener(() {
      minAreaController.text = formatter.format(spaceTemRange!.start.toInt());
    });
    maxAreaFocusNode.addListener(() {
      maxAreaController.text = formatter.format(spaceTemRange!.end.toInt());
    });
  }


  void onReady() {
    getExclusiveProjects();
    scrollController.addListener(scrollListener);
    consoleLog(projectCategories, key: 'p_categories');
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (hasNextPage) {
        getProjectsWithFiltering(pagination: true);
      }
    }
  }

  void getExclusiveProjects() {
    startLoading();
    ++page;
    ApiRequest(
      path: apiExclusiveProjects,
      formatResponse: true,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      body: {
        keyProjectStatus: projectStatus,
        keySortKey: selectedSortKey['key'] ?? null,
        keySortType: selectedSortType['key'] ?? null,
      },
      className: 'ProjectsListviewController/getExclusiveProjects',
    ).request(onSuccess: (dynamic data, dynamic response) {
      dismissLoading();
      this.data = data;
      projects.addAll(data[keyResults][keyFinalData][keyDocs]);
      typeFilter.addAll(data[keyResults][keyProjectCategories]);
      cities.addAll(data[keyResults][keyProjectCities]);
      realEstateDevelopers.addAll(data[keyResults][keyProjectDevelopers]);
      totalDocs = data[keyResults][keyFinalData][keyTotalDocs];

      isLoading = false;
      update();
    }, onError: (error) {
      isLoading = false;
      update();
    });
  }

  void update(){
    notifyListeners();
  }

  void getProjectsWithFiltering({bool pagination = false}) {
    if (!pagination) {
      page = 0;
    }
    ++page;
    startLoading();
    ApiRequest(
      path: apiExclusiveProjects,
      formatResponse: true,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      shouldShowRequestDetails: true,
      body: {
        keyPage: page,
        keyProjectStatus: projectStatus,
        ...filterMap,
        keySortKey: selectedSortKey['key'] ?? null,
        keySortType: selectedSortType['key'] ?? null,
        keyCategories: selectedTypeFilter.map((e) => e[keyID]).toList(),
        keyCityId: selectedCity.map((e) => e[keyID]).toList(),
        keyPurposeType: selectedFilteredPropertyPurpose['key'],
        keyProjectCategory: selectedProjectCategory[keySlug],
        keyNeighborhoodId: selectedNeighborhood.map((e) => e[keyID]).toList(),
        keyBedrooms: selectedRoomsNumber.map((e) => e['key']).toList(),
        keyDeveloper:
        selectedRealEstateDeveloper.map((e) => e[keyName]).toList(),
        'subCommunityId': selectedSubCommunity.map((e) => e[keyID]).toList(),
      },
      className: 'ProjectsListviewController/getProjectsWithFiltering',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (!pagination) {
          projects.clear();
        }
        totalDocs = data[keyResults][keyFinalData][keyTotalDocs];
        projects.addAll(data[keyResults][keyFinalData][keyDocs]);
        hasNextPage = data[keyResults][keyFinalData][keyHasNextPage];
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        update();
      },
    );
  }

  void onMinPriceTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    int price = int.parse(text);
    if (price > this.priceTemRange!.end) {
      return;
    }
    RangeValues priceRange;
    if (price < minPrice) {
      priceRange = RangeValues(minPrice.toDouble(), this.priceTemRange!.end);
    } else {
      priceRange = RangeValues(price.toDouble(), this.priceTemRange!.end);
    }
    this.priceTemRange = priceRange;
    update();
  }

  void onMaxPriceTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    int price = int.parse(text);
    if (price < this.priceTemRange!.start) {
      return;
    }
    RangeValues priceRange;
    if (price > maxPrice) {
      priceRange = RangeValues(this.priceTemRange!.start, maxPrice.toDouble());
    } else {
      priceRange = RangeValues(this.priceTemRange!.start, price.toDouble());
    }
    this.priceTemRange = priceRange;
    update();
  }

  void onMinAreaTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    int area = int.parse(text);
    if (area > this.spaceTemRange!.end) {
      return;
    }
    RangeValues areaRange;
    if (area < minSpace) {
      areaRange = RangeValues(minSpace.toDouble(), this.spaceTemRange!.end);
    } else {
      areaRange = RangeValues(area.toDouble(), this.spaceTemRange!.end);
    }
    this.spaceTemRange = areaRange;
    update();
  }

  void onMaxAreaTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    int area = int.parse(text);
    if (area < this.spaceTemRange!.start) {
      return;
    }
    RangeValues areaRange;
    if (area > maxSpace) {
      areaRange = RangeValues(this.spaceTemRange!.start, maxSpace.toDouble());
    } else {
      areaRange = RangeValues(this.spaceTemRange!.start, area.toDouble());
    }
    this.spaceTemRange = areaRange;
    update();
  }

  Future<void> getNeighborhood(List<dynamic> selectedCities,
      {bool withLoading = false}) async {
    neighborhoods.clear();
    subCommunities.clear();
    neighborhoods = await getNeighborHoodAppController(
      selectedCities,
      withLoading: withLoading,
    );

    update();
  }


  Future<List> getNeighborHoodAppController(
      List<dynamic> selectedCities, {
        bool withLoading = false,
      }) async {
    if (withLoading) {
      startLoading();
    }
    List<dynamic> neighborHoodList = [];

    await ApiRequest(
      path: apiCommunities,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      method: ApiMethods.post,
      formatResponse: true,
      body: {
        keyCityId: selectedCities.map((e) => e[keyID]).toList(),
      },
      className: 'MyAppController/getNeighborhood',
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        neighborHoodList = data[keyResults] ?? [];
        dismissLoading();
      },
    );

    return neighborHoodList;
  }

  void onTypeFilterPress(dynamic type) {
    if (selectedTypeFilter.contains(type)) {
      selectedTypeFilter.remove(type);
    } else {
      selectedTypeFilter.add(type);
    }

    consoleLog(selectedTypeFilter, key: 'selectedTypeFilter');
    getProjectsWithFiltering();
    update();
  }

  void onCityPress(dynamic city) {
    if (selectedCity.contains(city)) {
      selectedCity.remove(city);
      selectedTempCity.remove(city);

      selectedNeighborhood.clear();
    } else {
      selectedCity.add(city);
    }

    getNeighborhood(selectedCity);

    consoleLog(selectedCity, key: 'selectedCity');
    getProjectsWithFiltering();
    update();
  }

  onSelectTempCity(dynamic city) {
    if (selectedTempCity.contains(city)) {
      selectedTempCity.remove(city);
    } else {
      selectedTempCity.add(city);
    }

    getNeighborhood(selectedTempCity, withLoading: true);
    consoleLog(selectedTempCity, key: 'selectedTempCity');
    update();
  }

  void onTempNeighborhoodPress(dynamic neighborhood) {
    if (selectedTempNeighborhood.contains(neighborhood)) {
      selectedTempNeighborhood.remove(neighborhood);
    } else {
      selectedTempNeighborhood.add(neighborhood);
    }

    getSubCommunities();
    consoleLog(selectedTempNeighborhood, key: 'selectedNeighborhood');
    update();
  }

  void onTempSubCommunityPress(dynamic subComm) {
    if (selectedTemSubCommunity.contains(subComm)) {
      selectedTemSubCommunity.remove(subComm);
    } else {
      selectedTemSubCommunity.add(subComm);
    }

    consoleLog(selectedTemSubCommunity, key: 'selectedTemSubCommunity');
    update();
  }

  void onTempRealEstateDeveloperPress(dynamic realEstateDeveloper) {
    if (selectedTempRealEstateDeveloper.contains(realEstateDeveloper)) {
      selectedTempRealEstateDeveloper.remove(realEstateDeveloper);
    } else {
      selectedTempRealEstateDeveloper.add(realEstateDeveloper);
    }

    consoleLog(selectedRealEstateDeveloper, key: 'selectedRealEstateDeveloper');
    update();
  }

  void onTempFilteredPropertyPurposePressed(dynamic purpose) {
    if (selectedTemFilteredPropertyPurpose == purpose) {
      selectedTemFilteredPropertyPurpose = {};
    } else {
      selectedTemFilteredPropertyPurpose = purpose;
    }

    consoleLog(
      selectedTemFilteredPropertyPurpose,
      key: 'selectedTemFilteredPropertyPurpose',
    );
    update();
  }

  void onTempProjectCategoriesPressed(dynamic projectCategory) {
    if (selectedTemProjectsCategories == projectCategory) {
      selectedTemProjectsCategories = {};
    } else {
      selectedTemProjectsCategories = projectCategory;
    }

    consoleLog(
      selectedTemProjectsCategories,
      key: 'selectedTemProjectsCategories',
    );
    update();
  }

  void onShowAvailableUnitsToggled() {
    showAvailableUnits = !showAvailableUnits;
    update();
  }

  void openCustomBottomSheet() {
    resetToOriginalValues();

    if (selectedTempCity.isEmpty) {
      getNeighborhood(selectedTempCity, withLoading: false);
    }

    update();
    // bottomSheet(
    //
    //   BottomSheetContainer(
    //     title: FFLocalizations.of(context).getText('custom_filter'),
    //     totalPadding: EdgeInsets.all(0),
    //     titlePadding: DEVICE_HEIGHT * 0.0,
    //     titleVerticalPadding: DEVICE_HEIGHT * 0.04,
    //     titleHorizontalPadding: DEVICE_HEIGHT * 0.02,
    //     child: const ProjectListviewFilterSheet(),
    //     onClosingTheSheet: () {
    //       // When the user close the bottom sheet
    //
    //       resetToDefaultValues();
    //
    //       update();
    //
    //       Get.back();
    //     },
    //   ),
    //   isScrollControlled: true,
    //   isDismissible: false,
    // );
  }

  void onApplyFilterPress() {
    selectedCity = List.from(selectedTempCity);
    selectedNeighborhood = List.from(selectedTempNeighborhood);
    selectedRealEstateDeveloper = List.from(selectedTempRealEstateDeveloper);
    selectedFilteredPropertyPurpose = selectedTemFilteredPropertyPurpose;
    selectedProjectCategory = selectedTemProjectsCategories;
    selectedRoomsNumber = List.from(selectedTemRoomsNumber);
    selectedSubCommunity = List.from(selectedTemSubCommunity);

    priceRange = priceTemRange;
    spaceRange = spaceTemRange;

    filterMap[keyPriceMin] = priceRange!.start.round();
    filterMap[keyPriceMax] = priceRange!.end.round();
    filterMap[keyAreaMin] = spaceRange!.start.round();
    filterMap[keyAreaMax] = spaceRange!.end.round();

    // should be removed
    consoleLog(selectedRealEstateDeveloper);
    update();

    getProjectsWithFiltering();

    // Get.back(); todo
  }

  Future<void> onRefresh() async {
    isLoading = true;
    projects = [];
    data = {};
    page = 0;
    hasNextPage = true;
    update();
    getProjectsWithFiltering();
  }

  bool checkFilterApplied() {
    if ((selectedTypeFilter.isNotEmpty) ||
        (selectedCity.isNotEmpty) ||
        (selectedFilteredPropertyPurpose.isNotEmpty) ||
        (selectedNeighborhood.isNotEmpty) ||
        (selectedRoomsNumber.isNotEmpty) ||
        (selectedRealEstateDeveloper.isNotEmpty) ||
        (selectedProjectCategory.isNotEmpty) ||
        checkFilterOnSlider()) {
      return true;
    }
    return false;
  }

  void onTemRoomsNumberPress(dynamic item) {
    if (selectedTemRoomsNumber.contains(item)) {
      selectedTemRoomsNumber.remove(item);
    } else {
      selectedTemRoomsNumber.add(item);
    }

    consoleLog(selectedTemRoomsNumber, key: 'selectedTemRoomsNumber');
    update();
  }

  void onPriceRangeSliderChange(RangeValues rangeValues) {
    priceTemRange = rangeValues;
    minPriceController.text = formatter.format(priceTemRange!.start.toInt());
    maxPriceController.text = formatter.format(priceTemRange!.end.toInt());
    update();
  }

  void onSpaceRangeSliderChange(RangeValues rangeValues) {
    spaceTemRange = rangeValues;
    minAreaController.text = spaceTemRange!.start.toInt().toString();
    maxAreaController.text = spaceTemRange!.end.toInt().toString();
    update();
  }

  void resetToOriginalValues() {
    selectedTempCity = List.from(selectedCity);
    selectedTempNeighborhood = List.from(selectedNeighborhood);
    selectedTempRealEstateDeveloper = selectedRealEstateDeveloper;
    selectedTemFilteredPropertyPurpose = selectedFilteredPropertyPurpose;
    selectedTemProjectsCategories = selectedProjectCategory;
    selectedTemRoomsNumber = List.from(selectedRoomsNumber);
    selectedTemSubCommunity = List.from(selectedSubCommunity);
    priceTemRange = RangeValues(priceRange!.start, priceRange!.end);
    spaceTemRange = RangeValues(spaceRange!.start, spaceRange!.end);
    minAreaController.text = spaceTemRange!.start.toInt().toString();
    maxAreaController.text = spaceTemRange!.end.toInt().toString();
    minPriceController.text = formatter.format(priceTemRange!.start.toInt());
    maxPriceController.text = formatter.format(priceTemRange!.end.toInt());
  }

  void resetToDefaultValues() {
    selectedTempNeighborhood.clear();
    selectedTempCity.clear();
    selectedTempRealEstateDeveloper.clear();
    selectedTemFilteredPropertyPurpose = {};
    selectedTemProjectsCategories = {};
    selectedTemRoomsNumber.clear();
    selectedTemSubCommunity.clear();
    minPrice = FFAppState().masterDateJsonModel['priceRangeFilterProject']
    [0] ??
        0;
    maxPrice = FFAppState().masterDateJsonModel['priceRangeFilterProject']
    [1] ??
        100000;
    minSpace = FFAppState().masterDateJsonModel['areaRangeFilterProject']
    [0] ??
        0;
    maxSpace = FFAppState().masterDateJsonModel['areaRangeFilterProject']
    [1] ??
        500;
    minPriceController.text = formatter.format(minPrice);
    maxPriceController.text = formatter.format(maxPrice);
    minAreaController.text = minSpace.toString();
    maxAreaController.text = maxSpace.toString();
  }

  void onSortPressed() {
    selectedTemSortKey = selectedSortKey;
    selectedTemSortType = selectedSortType;
    // Get.bottomSheet( todo
    //   BottomSheetContainer(
    //     title: 'sortS'.tr,
    //     titlePadding: DEVICE_HEIGHT * 0.03,
    //     child: GetBuilder<ProjectsListviewController>(
    //       builder: (ProjectsListviewController controller) {
    //         return SortSheet(
    //           selectedTemSortKey: selectedTemSortKey,
    //           selectedTemSortType: selectedTemSortType,
    //           onSelectSortKey: onSelectSortKey,
    //           onSelectSortType: onSelectSortType,
    //           onApply: onApplySort,
    //           isProjectSort: true,
    //         );
    //       },
    //     ),
    //   ),
    //   isScrollControlled: true,
    // );
  }

  void getSubCommunities({bool withLoading = true}) {
    subCommunities.clear();
    selectedTemSubCommunity.clear();
    if (withLoading) {
      startLoading();
    }

    ApiRequest(
      path: apiCommunities,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      method: ApiMethods.post,
      className: 'RequestYourPropertyController/getCommunities',
      body: {
        keyNeighborhoodId:
        selectedTempNeighborhood.map((e) => e[keyID]).toList(),
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        if (response[keyResults].isNotEmpty) {
          subCommunities.addAll(response[keyResults]);
        }
        dismissLoading();
        update();
      },
    );
  }

  void onSelectSortKey(dynamic item) {
    if (selectedTemSortKey == item) {
      selectedTemSortKey = {};
    } else {
      selectedTemSortKey = item;
    }
    selectedTemSortType = {};

    consoleLog(selectedTemSortKey, key: 'selected_sort_key');
    update();
  }

  void onSelectSortType(dynamic item) {
    if (selectedTemSortType == item) {
      selectedTemSortType = {};
    } else {
      selectedTemSortType = item;
    }

    consoleLog(selectedTemSortType, key: 'selected_sort_type');
    update();
  }

  void onApplySort() {
    if (selectedTemSortKey.isEmpty || selectedTemSortType.isEmpty) {
      // showMessage(description: 'please_continue_selection'.tr); todo
      return;
    }
    selectedSortKey = selectedTemSortKey;
    selectedSortType = selectedTemSortType;
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeIn,
    );
    // Get.back();  todo
    getProjectsWithFiltering();
  }

  bool checkFilterOnSlider() {
    dynamic minPrice =
        FFAppState().masterDateJsonModel['priceRangeFilterProject'][0] ??
            0;
    dynamic maxPrice =
        FFAppState().masterDateJsonModel['priceRangeFilterProject'][1] ??
            100000;
    dynamic minSpace =
        FFAppState().masterDateJsonModel['areaRangeFilterProject'][0] ??
            0;
    dynamic maxSpace =
        FFAppState().masterDateJsonModel['areaRangeFilterProject'][1] ??
            500;

    if (priceRange!.start !=
        (minPrice is double ? minPrice : minPrice.toDouble())) {
      return true;
    }
    if (priceRange!.end !=
        (maxPrice is double ? maxPrice : maxPrice.toDouble())) {
      return true;
    }
    if (spaceRange!.start !=
        (minSpace is double ? minSpace : minSpace.toDouble())) {
      return true;
    }
    if (spaceRange!.end !=
        (maxSpace is double ? maxSpace : maxSpace.toDouble())) {
      return true;
    }

    return false;
  }

  void resetFilter() {
    selectedFilteredPropertyPurpose = {};
    selectedProjectCategory = {};
    selectedNeighborhood.clear();
    selectedRealEstateDeveloper.clear();
    selectedRoomsNumber.clear();
    selectedTypeFilter.clear();
    selectedCity.clear();
    selectedSubCommunity.clear();
    minPrice = FFAppState().masterDateJsonModel['priceRangeFilterProject']
    [0] ??
        0;
    maxPrice = FFAppState().masterDateJsonModel['priceRangeFilterProject']
    [1] ??
        100000;
    minSpace = FFAppState().masterDateJsonModel['areaRangeFilterProject']
    [0] ??
        0;
    maxSpace = FFAppState().masterDateJsonModel['areaRangeFilterProject']
    [1] ??
        500;
    minPriceController.text = formatter.format(minPrice);
    maxPriceController.text = formatter.format(maxPrice);
    minAreaController.text = minSpace.toString();
    maxAreaController.text = maxSpace.toString();
    priceRange = RangeValues(
      minPrice.toDouble(),
      maxPrice.toDouble(),
    );
    spaceRange = RangeValues(
      minSpace.toDouble(),
      maxSpace.toDouble(),
    );

    priceTemRange = priceRange;
    spaceTemRange = spaceRange;
    filterMap = {};
    page = 0;
    hasNextPage = true;

    getProjectsWithFiltering();
  }
}
