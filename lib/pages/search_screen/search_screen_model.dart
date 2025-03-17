import 'dart:async';

import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class SearchScreenModel extends ChangeNotifier {
  dynamic data;
  bool isLoading = true;
  bool orderByDistance = false;
  List<dynamic> selectedItems = [];
  List<dynamic> projectResult = [];
  List<dynamic> filterProcess = [];
  List<dynamic> purposeOfUse = [
    // {'key': 'any', keyValue: 'any'.tr}
  ];
  List<dynamic> cities = [];
  // List<dynamic> neighborhoods = [];
  List<dynamic> categories = [
    // {keyName: 'any'.tr, keyValue: 'any'}
  ];
  List<dynamic> typeOfProperty = [
    // {keyName: 'any'.tr, keyValue: 'any'}
  ];
  List<dynamic> roomsNumber = [];
  List<dynamic> bathroomsNumber = [];
  List<dynamic> selectedCities = [];
  List<dynamic> selectedNeighborhoods = [];
  Map<String, dynamic> selectedCategories = {};
  Map<String, dynamic> selectedPurposeOfUse = {};
  List<dynamic> selectedTypeOfProperty = [];
  List<dynamic> selectedRoomNumber = [];
  List<dynamic> selectedBathroomNumber = [];
  RangeValues? priceRange;
  RangeValues? areaRange;
  double minPrice = 0;
  double maxPrice = 1000000;
  double tempMinPrice = 0;
  double tempMaxPrice = 1000000;
  dynamic minArea = 0;
  dynamic maxArea = 500;
  dynamic tempMinArea = 0;
  dynamic tempMaxArea = 500;
  String searchKeyWord = '';
  ScrollController scrollController = ScrollController();
  int page = 0;
  bool hasNextPage = true;
  Timer? delay;
  List<dynamic> selectedCommunities = [];
  List<dynamic> selectedSubCommunities = [];
  List<dynamic> communities = [];
  List<dynamic> subCommunities = [];

  // when user edit on filter and cancel these lists will return the original selected filters
  Map<String, dynamic> tempPurposeOfUse = {};
  List<dynamic> tempCities = [];
  Map<String, dynamic> tempCategories = {};
  List<dynamic> tempNeighborhoods = [];
  List<dynamic> tempTypeOfProperty = [];
  List<dynamic> tempRoomsNumber = [];
  List<dynamic> tempBathroomsNumber = [];

  dynamic selectedSortKey = {};
  dynamic selectedSortType = {};
  dynamic selectedTemSortKey = {};
  dynamic selectedTemSortType = {};
  dynamic adBanner;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  NumberFormat formatter = NumberFormat('###,###,###');
  TextEditingController minAreaController = TextEditingController();
  TextEditingController maxAreaController = TextEditingController();
  FocusNode minPriceFocusNode = FocusNode();
  FocusNode maxPriceFocusNode = FocusNode();
  FocusNode minAreaFocusNode = FocusNode();
  FocusNode maxAreaFocusNode = FocusNode();

  void initState() {
    getFilteringFromMasterData();
    minPriceFocusNode.addListener(() {
      minPriceController.text = formatter.format(priceRange!.start.toInt());
    });
    maxPriceFocusNode.addListener(() {
      maxPriceController.text = formatter.format(priceRange!.end.toInt());
    });
    minAreaFocusNode.addListener(() {
      minAreaController.text = formatter.format(areaRange!.start.toInt());
    });
    maxAreaFocusNode.addListener(() {
      maxAreaController.text = formatter.format(areaRange!.end.toInt());
    });
    getPropertiesList();
    scrollController.addListener(scrollListener);
  }

  void setInitialTexts(BuildContext context) {
    filterProcess = [
      {
        keyId: 1,
        keyValue: 'City & neighborhood',
        keyName: FFLocalizations.of(context).getText('city_neighborhood'),
      },
      {
        keyId: 2,
        keyValue: 'Property type & Use',
        keyName: FFLocalizations.of(context).getText('property_type_use'),
      },
      {
        keyId: 3,
        keyValue: 'Price',
        keyName: FFLocalizations.of(context).getText('price'),
      },
      {
        keyId: 4,
        keyValue: 'Area',
        keyName: FFLocalizations.of(context).getText('area'),
      },
      {
        keyId: 5,
        keyValue: 'Beds & Baths',
        keyName: FFLocalizations.of(context).getText('beds_baths'),
      },
    ];
    roomsNumber = [
      {
        'key': 'any',
        keyValue: FFLocalizations.of(context).getText('any'),
      },
    ];
    bathroomsNumber = [
      {
        'key': 'any',
        keyValue: FFLocalizations.of(context).getText('any'),
      },
    ];
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (hasNextPage) {
        getPropertiesList(pagination: true);
      }
    }
  }

  void onCommunityPress(dynamic community) {
    if (selectedCommunities.contains(community)) {
      selectedCommunities.remove(community);
    } else {
      selectedCommunities.add(community);
    }
    getSubCommunities();
    notifyListeners();
  }

  void onSubCommunityPress(dynamic subCommunity) {
    if (selectedSubCommunities.contains(subCommunity)) {
      selectedSubCommunities.remove(subCommunity);
    } else {
      selectedSubCommunities.add(subCommunity);
    }
    notifyListeners();
  }

  void getCommunities() {
    // neighborhoods.clear();
    // markers.clear();
    // selectedNeighborhoods.clear();
    // notifyListeners();
    startLoading();
    ApiRequest(
      path: apiCommunities,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      className: 'SearchScreenController/getCommunities',
      body: {
        keyCityId: selectedCities.map((e) => e['_id']).toList(),
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        communities.clear();
        if (response[keyResults].isNotEmpty) {
          // neighborhoods.addAll(response[keyResults]);
          communities.addAll(response[keyResults]);
          // for (var element in communities) {
          //   await addMarker(element);
          // }
        }
        // fitCameraBasedOnLatLngList(
        //   mapController,
        //   neighborhoods
        //       .map((e) => LatLng(e[keyLocation][1], e[keyLocation][0]))
        //       .toList(),
        // );
        dismissLoading();
        notifyListeners();
      },
    );
  }

  void getSubCommunities() {
    startLoading();
    ApiRequest(
      path: apiCommunities,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      className: 'SearchScreenController/getCommunities',
      body: {
        keyNeighborhoodId: selectedCommunities.map((e) => e['_id']).toList(),
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        subCommunities.clear();
        if (response[keyResults].isNotEmpty) {
          subCommunities.addAll(response[keyResults]);
        }
        dismissLoading();
        notifyListeners();
      },
    );
  }

  void getPropertiesList({
    bool pagination = false,
    bool filter = false,
  }) {
    if (!pagination && !filter) {
      isLoading = true;
    }

    ++page;
    startLoading();
    ApiRequest(
      path: apiPropertiesList,
      defaultHeadersValue: false,
      method: ApiMethods.post,
      formatResponse: true,
      className: 'SearchScreenController/getPropertiesList',
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      body: {
        keyPage: page,
        ...getBody(),
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        this.data = data;
        adBanner = data[keyResults][keyAdBanner];
        projectResult.addAll(data[keyResults][keyFinalData][keyDocs]);
        consoleLogPretty(data[keyResults][keyFinalData][keyDocs], key: 'data');
        hasNextPage = data[keyResults][keyFinalData][keyHasNextPage];
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void onMinPriceTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int price = int.parse(text);
    if (price > this.priceRange!.end) {
      return;
    }
    RangeValues priceRange;
    if (price < minPrice) {
      priceRange = RangeValues(minPrice.toDouble(), this.priceRange!.end);
    } else {
      priceRange = RangeValues(price.toDouble(), this.priceRange!.end);
    }
    this.priceRange = priceRange;
    notifyListeners();
  }

  void onMaxPriceTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int price = int.parse(text);
    if (price < this.priceRange!.start) {
      return;
    }
    RangeValues priceRange;
    if (price > maxPrice) {
      priceRange = RangeValues(this.priceRange!.start, maxPrice.toDouble());
    } else {
      priceRange = RangeValues(this.priceRange!.start, price.toDouble());
    }
    this.priceRange = priceRange;
    notifyListeners();
  }

  void onMinAreaTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int area = int.parse(text);
    if (area > maxArea) {
      return;
    }
    RangeValues areaRange;
    if (area < this.areaRange!.start) {
      areaRange = RangeValues(minArea.toDouble(), this.areaRange!.end);
    } else {
      areaRange = RangeValues(area.toDouble(), this.areaRange!.end);
    }
    this.areaRange = areaRange;
    notifyListeners();
  }

  void onMaxAreaTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int area = int.parse(text);
    if (area < this.areaRange!.start) {
      return;
    }
    RangeValues areaRange;
    if (area > maxArea) {
      areaRange = RangeValues(this.areaRange!.start, maxArea.toDouble());
    } else {
      areaRange = RangeValues(this.areaRange!.start, area.toDouble());
    }
    this.areaRange = areaRange;
    notifyListeners();
  }

  void setSelectedItems(
    dynamic item, {
    ListTypes type = ListTypes.add,
  }) {
    if (type == ListTypes.remove) {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      }
    } else if (type == ListTypes.add) {
      if (!selectedItems.contains(item)) {
        selectedItems.add(item);
      }
    }
    notifyListeners();
  }

  void onSearchTextChange(String text) {
    reset();
    searchKeyWord = text;

    if (delay?.isActive ?? false) delay!.cancel();
    delay = Timer(
      const Duration(milliseconds: 500),
      () {
        getPropertiesList(filter: true);
      },
    );

    notifyListeners();
  }

  void onPriceRangeSliderChange(RangeValues rangeValues) {
    priceRange = rangeValues;
    minPriceController.text = formatter.format(priceRange!.start.toInt());
    maxPriceController.text = formatter.format(priceRange!.end.toInt());
    notifyListeners();
  }

  void onAreaFilterChange(RangeValues rangeValues) {
    areaRange = rangeValues;
    minAreaController.text = formatter.format(areaRange!.start.toInt());
    maxAreaController.text = formatter.format(areaRange!.end.toInt());
    notifyListeners();
  }

  Future<void> onCityPress(dynamic city) async {
    if (selectedCities.contains(city)) {
      selectedCities.remove(city);
    } else {
      selectedCities.add(city);
    }
    // neighborhoods.clear();
    selectedNeighborhoods.clear();
    tempNeighborhoods.clear();

    // neighborhoods = await myAppController.getNeighborHood(
    //   selectedCities,
    //   withLoading: true,
    // );
    getCommunities();

    notifyListeners();
  }

  void onNeighborhoodPress(dynamic neighborhood) {
    if (selectedNeighborhoods.contains(neighborhood)) {
      selectedNeighborhoods.remove(neighborhood);
    } else {
      selectedNeighborhoods.add(neighborhood);
    }

    notifyListeners();
  }

  void onCategoryPress(dynamic category) {
    selectedCategories = category;
    setMinMaxPrice();
    getPropertyType();
    notifyListeners();
  }

  void setMinMaxPrice() {
    final dynamic masterData = FFAppState().masterDateJsonModel;
    if (selectedCategories[keySlug] == 'buy') {
      minPrice = masterData[keyBuyPriceRange][0].toDouble();
      maxPrice = masterData[keyBuyPriceRange][1].toDouble();
    } else {
      minPrice = masterData[keyRentPriceRange][0].toDouble();
      maxPrice = masterData[keyRentPriceRange][1].toDouble();
    }
    priceRange = RangeValues(minPrice, maxPrice);
    tempMinPrice = minPrice;
    tempMaxPrice = maxPrice;
    minPriceController.text = formatter.format(minPrice);
    maxPriceController.text = formatter.format(maxPrice);
  }

  void onPurposeOfUseSelected(dynamic purpose) {
    if (selectedPurposeOfUse == purpose) {
      selectedPurposeOfUse = {};
    } else {
      selectedPurposeOfUse = purpose;
    }

    getPropertyType();
    notifyListeners();
  }

  void onTypeOfPropertySelected(dynamic type) {
    if (selectedTypeOfProperty.contains(type)) {
      selectedTypeOfProperty.remove(type);
    } else {
      selectedTypeOfProperty.add(type);
    }

    notifyListeners();
  }

  void onRoomNumberSelected(dynamic room) {
    if (selectedRoomNumber.contains(room)) {
      selectedRoomNumber.remove(room);
    } else {
      selectedRoomNumber.add(room);
    }

    notifyListeners();
  }

  void onBathroomNumberSelected(dynamic bathroom) {
    if (selectedBathroomNumber.contains(bathroom)) {
      selectedBathroomNumber.remove(bathroom);
    } else {
      selectedBathroomNumber.add(bathroom);
    }

    notifyListeners();
  }

  void onFilterProcessPress(dynamic item, BuildContext context) {
    if (item[keyId] == 1) {
      tempCities = List.from(selectedCities);
      tempNeighborhoods = List.from(selectedNeighborhoods);
      SideSheet.show(
        context,
        child: const CityFilterSheet(),
        title:
            '${FFLocalizations.of(context).getText('filter')} : ${FFLocalizations.of(context).getText('city_neighborhood')}',
      );
    } else if (item[keyId] == 2) {
      tempPurposeOfUse = selectedPurposeOfUse;
      tempCategories = selectedCategories;
      tempTypeOfProperty = List.from(selectedTypeOfProperty);
      SideSheet.show(
        context,
        child: const PropertyTypeFilterSheet(),
        title:
            '${FFLocalizations.of(context).getText('filter')} : ${FFLocalizations.of(context).getText('property_type_use')}',
      );
    } else if (item[keyId] == 3) {
      tempMinPrice = priceRange!.start.toDouble();
      tempMaxPrice = priceRange!.end.toDouble();
      SideSheet.show(
        context,
        child: const PriceFilterSheet(),
        title:
            '${FFLocalizations.of(context).getText('price_range')} (${getCurrency()})',
      );
    } else if (item[keyId] == 4) {
      tempMinArea = areaRange!.start.toInt();
      tempMaxArea = areaRange!.end.toInt();
      SideSheet.show(
        context,
        child: const AreaFilterSheet(),
        title: FFLocalizations.of(context).getText('area_range'),
      );
    } else if (item[keyId] == 5) {
      tempRoomsNumber = List.from(selectedRoomNumber);
      tempBathroomsNumber = List.from(selectedBathroomNumber);
      SideSheet.show(
        context,
        child: const BedBathFilterSheet(),
        title:
            '${FFLocalizations.of(context).getText('filter')}: ${FFLocalizations.of(context).getText('bedrooms')}, ${FFLocalizations.of(context).getText('bathrooms')}',
      );
    }
  }

  void onApplyFilterPress(BuildContext context) {
    reset();
    Navigator.pop(context);
    isLoading = true;
    getPropertiesList(
      filter: true,
    );
  }

  void reset() {
    page = 0;
    projectResult = [];
    notifyListeners();
  }

  void favorites(dynamic property, BuildContext context) {
    final favoritesModel = context.read<FavoritesModel>();
    favoritesModel.addOrRemoveFromFavorite(
      property[keyID],
      PropertyType.property,
      onSuccessLogin: () {
        reset();
        getPropertiesList();
      },
      onRequestSuccess: () {
        property[keyIsWishListed] = !property[keyIsWishListed];
        notifyListeners();
      },
      bodyKey: 'propertyId',
    );
  }

  void getFilteringFromMasterData() {
    cities.addAll(FFAppState().masterDateJsonModel[keyCities]);
    categories.addAll(FFAppState().masterDateJsonModel[keyProjectCategories]);
    selectedCategories = categories.first;
    setMinMaxPrice();
    purposeOfUse
        .addAll(FFAppState().masterDateJsonModel[keyFilteredPropertyPurpose]);
    // typeOfProperty.addAll(FFAppState().masterDateJsonModel[keyFilteredPropertyTypes]);
    minArea = FFAppState()
            .masterDateJsonModel[keyAreaRangeFilterProject][0]
            .toDouble() ??
        0.0;
    minAreaController.text = formatter.format(minArea);
    maxArea = FFAppState()
            .masterDateJsonModel[keyAreaRangeFilterProject][1]
            .toDouble() ??
        500.0;
    maxAreaController.text = formatter.format(maxArea);
    areaRange = RangeValues(
      minArea.toDouble(),
      maxArea.toDouble(),
    );
    roomsNumber.addAll(FFAppState().masterDateJsonModel[keyRooms]);
    bathroomsNumber.addAll(FFAppState().masterDateJsonModel[keyBathrooms]);
  }

  Map<String, dynamic> getBody() {
    consoleLog(selectedTypeOfProperty);
    final dynamic body = <String, dynamic>{
      keyWord: searchKeyWord,
      keySortKey: selectedSortKey['key'],
      keySortType: selectedSortType['key'],
      keyCityId: selectedCities.map((e) => e[keyID]).toList(),
      'communityId': selectedCommunities.map((e) => e['_id']).toList(),
      'subCommunityId': selectedSubCommunities.map((e) => e['_id']).toList(),
      keyNeighborhoodId: selectedNeighborhoods.map((e) => e[keyID]).toList(),
      keyPropertyCategory: selectedTypeOfProperty
          .where((e) => e[keyValue] != 'any')
          .map((e) => e[keyID])
          .toList(),
      keyPropertyType: selectedCategories[keySlug],
      keyPurposeOfUse: selectedPurposeOfUse['key'],
      keyPriceMin: priceRange!.start.toInt(),
      keyPriceMax: priceRange!.end.toInt(),
      keyAreaMin: areaRange!.start.toInt(),
      keyAreaMax: areaRange!.end.toInt(),
      keyRoom: selectedRoomNumber
          .where((e) => e['key'] != 'any')
          .map((e) => e['key'])
          .toList(),
      keyBathRoom: selectedBathroomNumber
          .where((e) => e['key'] != 'any')
          .map((e) => e['key'])
          .toList(),
    };

    if (locationData != null && orderByDistance) {
      body[keyLongitude] = locationData!.longitude;
      body[keyLatitude] = locationData!.latitude;
    }

    return body;
  }

  void onPropertyPressed(dynamic id) {
    // Get.toNamed(
    //   routePropertyDetails,
    //   arguments: id,
    // );
  }

  Future<void> onRefresh() async {
    reset();
    getPropertiesList();
  }

  void onSortPressed() {
    selectedTemSortKey = selectedSortKey;
    selectedTemSortType = selectedSortType;
    // Get.bottomSheet(
    //   BottomSheetContainer(
    //     title: 'sortS'.tr,
    //     titlePadding: DEVICE_HEIGHT * 0.03,
    //     child: GetBuilder<SearchScreenController>(
    //       builder: (SearchScreenController controller) {
    //         return SortSheet(
    //           selectedTemSortKey: selectedTemSortKey,
    //           selectedTemSortType: selectedTemSortType,
    //           onSelectSortKey: onSelectSortKey,
    //           onSelectSortType: onSelectSortType,
    //           onApply: onApplySort,
    //         );
    //       },
    //     ),
    //   ),
    //   isScrollControlled: true,
    // );
  }

  void onSelectSortKey(dynamic item) {
    if (selectedTemSortKey == item) {
      selectedTemSortKey = {};
    } else {
      selectedTemSortKey = item;
    }
    selectedTemSortType = {};

    notifyListeners();
  }

  void onSelectSortType(dynamic item) {
    if (selectedTemSortType == item) {
      selectedTemSortType = {};
    } else {
      selectedTemSortType = item;
    }

    notifyListeners();
  }

  void onApplySort(BuildContext context) {
    if (selectedTemSortKey.isEmpty || selectedTemSortType.isEmpty) {
      showToast(
          FFLocalizations.of(context).getText('please_continue_selection'));
      return;
    }

    selectedSortKey = selectedTemSortKey;
    selectedSortType = selectedTemSortType;

    reset();
    Navigator.pop(context);
    getPropertiesList(filter: true);
  }

  Future<void> onOrderByDistancePressed() async {
    orderByDistance = !orderByDistance;
    if (orderByDistance) {
      await _getLocation();
    }
    if (locationData != null) {
      reset();
      getPropertiesList();
    }
    notifyListeners();
  }

  Future<void> _getLocation() async {
    if (locationData == null) {
      await getCurrentLocation();
    }
    notifyListeners();
  }

  void getPropertyType() {
    selectedTypeOfProperty = [];
    if ((selectedCategories.isEmpty) || (selectedPurposeOfUse.isEmpty)) {
      typeOfProperty = [];
      notifyListeners();
      return;
    }

    startLoading();
    ApiRequest(
      path: apiGetPropertyType,
      formatResponse: true,
      className: 'RequestYourPropertyController/getPropertyType',
      queryParameters: {
        keySlug:
            '${selectedCategories[keySlug]},${selectedPurposeOfUse['key']}',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        typeOfProperty = [];
        if (response[keySuccess] && response[keyResults].isNotEmpty) {
          typeOfProperty = response[keyResults][keyFilteredPropertyTypes] ?? [];
        }
        dismissLoading();
        notifyListeners();
      },
    );
  }

  void resetFilters() {
    selectedCities = [];
    selectedNeighborhoods = [];
    selectedCategories = categories.first;
    selectedPurposeOfUse = {};
    selectedTypeOfProperty = [];
    selectedRoomNumber = [];
    selectedBathroomNumber = [];
    selectedCommunities = [];
    selectedSubCommunities = [];
    selectedItems.clear();
    setMinMaxPrice();
    areaRange = RangeValues(
      minArea.toDouble(),
      maxArea.toDouble(),
    );

    reset();
    getPropertiesList(filter: true);
  }
}

enum ListTypes {
  add,
  remove,
}
