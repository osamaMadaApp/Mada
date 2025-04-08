import 'dart:async';

import 'package:intl/intl.dart';

import '../../app_state.dart';
import '../../general_exports.dart';

class ProjectUnitsListviewModel extends ChangeNotifier {
  dynamic data;
  dynamic savedFilterData;
  bool? availableSelected;
  bool? bookedSelected;
  bool? soldSelected;
  List<dynamic> floors = [];
  List<dynamic> roomsNumber = [];
  List<dynamic> bathroomsNumber = [];
  List<dynamic> selectedFloor = [];
  List<dynamic> selectedRoomsNumber = [];
  List<dynamic> selectedBathroomsNumber = [];
  List<dynamic> selectedTemFloor = [];
  List<dynamic> selectedTemRoomsNumber = [];
  List<dynamic> selectedTemBathroomsNumber = [];
  RangeValues? priceRange;
  RangeValues? priceTemRange;
  RangeValues? spaceRange;
  RangeValues? spaceTemRange;
  dynamic minPrice = -1;
  dynamic minSpace = -1;
  dynamic maxPrice = -1;
  dynamic maxSpace = -1;
  dynamic minTemPrice = -1;
  dynamic minTemSpace = -1;
  dynamic maxTemPrice = -1;
  dynamic maxTemSpace = -1;
  bool isLoading = true;
  dynamic selectedSortKey = {};
  dynamic selectedSortType = {};
  dynamic selectedTemSortKey = {};
  dynamic selectedTemSortType = {};
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  NumberFormat formatter = NumberFormat('###,###,###');
  TextEditingController minAreaController = TextEditingController();
  TextEditingController maxAreaController = TextEditingController();
  FocusNode minPriceFocusNode = FocusNode();
  FocusNode maxPriceFocusNode = FocusNode();
  FocusNode minAreaFocusNode = FocusNode();
  FocusNode maxAreaFocusNode = FocusNode();
  String searchKeyWord = '';
  Timer? delay;
  String projectId = '';

  void initState(dynamic projectId) {
    this.projectId = projectId;
    final dynamic masterData = FFAppState().masterDateJsonModel;
    minPrice = masterData[keyPriceRangeFilterUnit][0] ?? 0;
    maxPrice = masterData[keyPriceRangeFilterUnit][1] ?? 100000;
    minSpace = masterData[keyAreaRangeFilterUnit][0] ?? 0;
    maxSpace = masterData[keyAreaRangeFilterUnit][1] ?? 500;
    minPriceController.text = formatter.format(minPrice);
    maxPriceController.text = formatter.format(maxPrice);
    minAreaController.text = formatter.format(minSpace);
    maxAreaController.text = formatter.format(maxSpace);
    priceRange = RangeValues(
      minPrice.toDouble(),
      maxPrice.toDouble(),
    );
    spaceRange = RangeValues(
      minSpace.toDouble(),
      maxSpace.toDouble(),
    );
    minTemPrice = minPrice;
    maxTemPrice = maxPrice;
    minTemSpace = minSpace;
    maxTemSpace = maxSpace;
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
    getProjectUnits(hideScreen: true);
    resetFilter();
  }

  void resetFilter(){
    availableSelected = false;
    bookedSelected = false;
    soldSelected = false;
    notifyListeners();
  }

  void makeAvailableSelected(){
    bookedSelected = false;
    soldSelected = false;
    availableSelected = !availableSelected!;
    notifyListeners();
  }
  void makeBookedSelected(){
    availableSelected = false;
    soldSelected = false;
    bookedSelected = !bookedSelected!;
    notifyListeners();
  }
  void makeSoldSelected(){
    availableSelected = false;
    bookedSelected = false;
    soldSelected = !soldSelected!;
    notifyListeners();
  }

  void makeAvailableSelectedList(){
    final List<Map<String, dynamic>> fullData = List<Map<String, dynamic>>.from(data[keyResults][keyUnits]);

    final List<Map<String, dynamic>> filteredData = [];

    for (var floor in fullData) {
      final rawUnits = floor['units'];
      if (rawUnits is List) {
        final units = rawUnits.cast<Map<String, dynamic>>();
        final List<Map<String, dynamic>> availableUnits = [];

        for (var unit in units) {
          if ((unit['status'] as String?)?.toLowerCase() == 'available') {
            availableUnits.add(Map<String, dynamic>.from(unit)); // deep copy unit
          }
        }

        // Only include the floor if it has available units
        if (availableUnits.isNotEmpty) {
          filteredData.add({
            '_id': floor['_id'],
            'units': availableUnits,
          });
        }
      }
    }

    savedFilterData = filteredData;
    notifyListeners();
  }

  void makeBookedSelectedList(){
    final List<Map<String, dynamic>> fullData = List<Map<String, dynamic>>.from(data[keyResults][keyUnits]);
    final List<Map<String, dynamic>> filteredData = [];
    for (var floor in fullData) {
      final rawUnits = floor['units'];
      if (rawUnits is List) {
        final units = rawUnits.cast<Map<String, dynamic>>();
        final List<Map<String, dynamic>> availableUnits = [];

        for (var unit in units) {
          if ((unit['status'] as String?)?.toLowerCase() == 'reserved' || (unit['status'] as String?)?.toLowerCase() == 'booked' ) {
            availableUnits.add(Map<String, dynamic>.from(unit)); // deep copy unit
          }
        }

        // Only include the floor if it has available units
        if (availableUnits.isNotEmpty) {
          filteredData.add({
            '_id': floor['_id'],
            'units': availableUnits,
          });
        }
      }
    }

    savedFilterData = filteredData;
    notifyListeners();
  }
  void makeSoldSelectedList(){
    final List<Map<String, dynamic>> fullData = List<Map<String, dynamic>>.from(data[keyResults][keyUnits]);
    final List<Map<String, dynamic>> filteredData = [];
    for (var floor in fullData) {
      final rawUnits = floor['units'];
      if (rawUnits is List) {
        final units = rawUnits.cast<Map<String, dynamic>>();
        final List<Map<String, dynamic>> availableUnits = [];

        for (var unit in units) {
          if ((unit['status'] as String?)?.toLowerCase() == 'sold out' ) {
            availableUnits.add(Map<String, dynamic>.from(unit)); // deep copy unit
          }
        }

        // Only include the floor if it has available units
        if (availableUnits.isNotEmpty) {
          filteredData.add({
            '_id': floor['_id'],
            'units': availableUnits,
          });
        }
      }
    }

    savedFilterData = filteredData;
    notifyListeners();
  }


  void getProjectUnits({bool hideScreen = false, bool withReset = false}) {
    if (hideScreen) {
      isLoading = true;
      notifyListeners();
    }
    if (withReset) {
      data = null;
      floors = [];
      bathroomsNumber = [];
      roomsNumber = [];
      resetToOriginal();
    }

    startLoading();
    ApiRequest(
      path: apiUnits,
      method: ApiMethods.post,
      formatResponse: true,
      defaultHeadersValue: false,
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      className: 'ProjectUnitsListview/getProjectUnits',
      body: {
        keyProjectId: projectId,
        'keyword': searchKeyWord,
        keyFloor: selectedFloor.map((e) => e['key']).toList(),
        keyBedroom: selectedRoomsNumber.map((e) => e['key']).toList(),
        keyBathRoom: selectedBathroomsNumber.map((e) => e['key']).toList(),
        keySortKey: selectedSortKey['key'],
        keySortType: selectedSortType['key'],
        keyPriceRange:
            minPrice != -1 ? ('${priceRange!.start}-${priceRange!.end}') : null,
        keyArea:
            minSpace != -1 ? ('${spaceRange!.start}-${spaceRange!.end}') : null,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        this.data = data;
        if (data[keyResults].isNotEmpty) {
          final dynamic filterData = data[keyResults][keyFilterData];
          floors.addAll(filterData[keyFloors]);
          bathroomsNumber.addAll(filterData[keyBathrooms]);
          roomsNumber.addAll(filterData[keyRooms]);
        }

        isLoading = false;
        notifyListeners();
      },
    );
  }

  void onFloorPress(dynamic item) {
    if (selectedTemFloor.contains(item)) {
      selectedTemFloor.remove(item);
    } else {
      selectedTemFloor.add(item);
    }
    notifyListeners();
  }

  void onRoomsNumberPress(dynamic item) {
    if (selectedTemRoomsNumber.contains(item)) {
      selectedTemRoomsNumber.remove(item);
    } else {
      selectedTemRoomsNumber.add(item);
    }
    notifyListeners();
  }

  void onBathroomsNumberPress(dynamic item) {
    if (selectedTemBathroomsNumber.contains(item)) {
      selectedTemBathroomsNumber.remove(item);
    } else {
      selectedTemBathroomsNumber.add(item);
    }

    notifyListeners();
  }

  void onPriceRangeSliderChange(RangeValues rangeValues) {
    priceTemRange = rangeValues;
    minPriceController.text = formatter.format(priceTemRange!.start.toInt());
    maxPriceController.text = formatter.format(priceTemRange!.end.toInt());
    notifyListeners();
  }

  void onMinPriceTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int price = int.parse(text);
    if (price > priceTemRange!.end) {
      return;
    }
    RangeValues priceRange;
    if (price < minPrice) {
      priceRange = RangeValues(minPrice.toDouble(), priceTemRange!.end);
    } else {
      priceRange = RangeValues(price.toDouble(), priceTemRange!.end);
    }
    priceTemRange = priceRange;
    notifyListeners();
  }

  void onMaxPriceTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int price = int.parse(text);
    if (price < priceTemRange!.start) {
      return;
    }
    RangeValues priceRange;
    if (price > maxPrice) {
      priceRange = RangeValues(priceTemRange!.start, maxPrice.toDouble());
    } else {
      priceRange = RangeValues(priceTemRange!.start, price.toDouble());
    }
    priceTemRange = priceRange;
    notifyListeners();
  }

  void onMinAreaTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int area = int.parse(text);
    if (area > spaceTemRange!.end) {
      return;
    }
    RangeValues areaRange;
    if (area < minSpace) {
      areaRange = RangeValues(minSpace.toDouble(), spaceTemRange!.end);
    } else {
      areaRange = RangeValues(area.toDouble(), spaceTemRange!.end);
    }
    spaceTemRange = areaRange;
    notifyListeners();
  }

  void onMaxAreaTextChange(String text) {
    text = text.replaceAll(',', '');
    if (text.isEmpty) {
      return;
    }
    final int area = int.parse(text);
    if (area < spaceTemRange!.start) {
      return;
    }
    RangeValues areaRange;
    if (area > maxSpace) {
      areaRange = RangeValues(spaceTemRange!.start, maxSpace.toDouble());
    } else {
      areaRange = RangeValues(spaceTemRange!.start, area.toDouble());
    }
    spaceTemRange = areaRange;
    notifyListeners();
  }

  void onSpaceRangeSliderChange(RangeValues rangeValues) {
    spaceTemRange = rangeValues;
    minAreaController.text = formatter.format(spaceTemRange!.start.toInt());
    maxAreaController.text = formatter.format(spaceTemRange!.end.toInt());
    notifyListeners();
  }

  void openCustomFilterBottomSheet(BuildContext context) {
    selectedTemBathroomsNumber = List.from(selectedBathroomsNumber);
    selectedTemFloor = List.from(selectedFloor);
    selectedTemRoomsNumber = List.from(selectedRoomsNumber);
    priceTemRange = RangeValues(priceRange!.start, priceRange!.end);
    spaceTemRange = RangeValues(spaceRange!.start, spaceRange!.end);

    SideSheet.show(
      context,
      child: ChangeNotifierProvider.value(
        value: Provider.of<ProjectUnitsListviewModel>(context, listen: false),
        child: const ProjectUnitsListviewFilterSheet(),
      ),
      onClosingSheet: () {
        resetToOriginal();
        Navigator.pop(context);
      },
      title: FFLocalizations.of(context).getText('custom_filter'),
    );
  }

  void resetToOriginal() {
    final dynamic masterData = FFAppState().masterDateJsonModel;
    selectedTemBathroomsNumber.clear();
    selectedTemFloor.clear();
    selectedTemRoomsNumber.clear();

    minPrice = masterData[keyPriceRangeFilterUnit][0] ?? 0;
    maxPrice = masterData[keyPriceRangeFilterUnit][1] ?? 100000;
    minSpace = masterData[keyAreaRangeFilterUnit][0] ?? 0;
    maxSpace = masterData[keyAreaRangeFilterUnit][1] ?? 500;
    minPriceController.text = formatter.format(minPrice);
    maxPriceController.text = formatter.format(maxPrice);
    minAreaController.text = formatter.format(minSpace);
    maxAreaController.text = formatter.format(maxSpace);
    priceRange = RangeValues(
      minPrice.toDouble(),
      maxPrice.toDouble(),
    );
    spaceRange = RangeValues(
      minSpace.toDouble(),
      maxSpace.toDouble(),
    );
    minTemPrice = minPrice;
    maxTemPrice = maxPrice;
    minTemSpace = minSpace;
    maxTemSpace = maxSpace;
    priceTemRange = priceRange;
    spaceTemRange = spaceRange;

    notifyListeners();
  }

  void onSearchFieldSubmitted(String value) {
    searchKeyWord = value;

    if (delay?.isActive ?? false) delay!.cancel();
    delay = Timer(
      const Duration(milliseconds: 500),
      () {
        getProjectUnits();
      },
    );
  }

  void favorites(dynamic unit, BuildContext context) {
    final favoritesModel = context.read<FavoritesModel>();
    favoritesModel.addOrRemoveFromFavorite(
      unit[keyID],
      PropertyType.unit,
      onSuccessLogin: () {
        getProjectUnits();
      },
      onRequestSuccess: () {
        unit[keyIsWishListed] = !unit[keyIsWishListed];
        notifyListeners();
      },
    );
  }

  num getTotalNumberOfUnits() {
    num totalNumberOfUnits = 0;
    if (data != null && data[keyResults].isNotEmpty) {
      for (final result in data[keyResults][keyUnits]) {
        totalNumberOfUnits += result[keyUnits].length;
      }
    }
    return totalNumberOfUnits;
  }

  void onApplyFilterPress(BuildContext context) {
    Navigator.pop(context);
    selectedFloor = selectedTemFloor;
    selectedBathroomsNumber = selectedTemBathroomsNumber;
    selectedRoomsNumber = selectedTemRoomsNumber;
    priceRange = priceTemRange;
    spaceRange = spaceTemRange;

    getProjectUnits();
  }

  Future<void> onRefresh() async {
    getProjectUnits(hideScreen: true);
  }

  void onSortPressed(BuildContext context) {
    selectedTemSortKey = selectedSortKey;
    selectedTemSortType = selectedSortType;
    SideSheet.show(
      context,
      child: ChangeNotifierProvider.value(
        value: Provider.of<ProjectUnitsListviewModel>(context, listen: false),
        child: SortSheet(
          onSelectSortKey: onSelectSortKey,
          onSelectSortType: onSelectSortType,
          onApply: () => onApplySort(context),
        ),
      ),
      title: FFLocalizations.of(context).getText('sort'),
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
    notifyListeners();
  }

  void onSelectSortType(dynamic item) {
    if (selectedTemSortType == item) {
      selectedTemSortType = {};
    } else {
      selectedTemSortType = item;
    }

    consoleLog(selectedTemSortType, key: 'selected_sort_type');
    notifyListeners();
  }

  void onApplySort(BuildContext context) {
    if (selectedTemSortKey.isEmpty || selectedTemSortType.isEmpty) {
      showToast(
        FFLocalizations.of(context).getText('please_continue_selection'),
      );
      return;
    }

    selectedSortKey = selectedTemSortKey;
    selectedSortType = selectedTemSortType;
    Navigator.pop(context);
    getProjectUnits();
  }

  bool checkFilterApplied() {
    if ((selectedFloor.isNotEmpty) ||
        (selectedBathroomsNumber.isNotEmpty) ||
        (selectedRoomsNumber.isNotEmpty) ||
        checkFilterOnSlider()) {
      return true;
    }
    return false;
  }

  bool checkFilterOnSlider() {
    final dynamic masterData = FFAppState().masterDateJsonModel;
    final dynamic minPrice = masterData[keyPriceRangeFilterUnit] != null
        ? masterData[keyPriceRangeFilterUnit][0]
        : 0;
    final dynamic maxPrice = masterData[keyPriceRangeFilterUnit] != null
        ? masterData[keyPriceRangeFilterUnit][1]
        : 100000;

    final dynamic minSpace = masterData[keyAreaRangeFilterUnit] != null
        ? masterData[keyAreaRangeFilterUnit][0]
        : 0;
    final dynamic maxSpace = masterData[keyAreaRangeFilterUnit] != null
        ? masterData[keyAreaRangeFilterUnit][1]
        : 500;

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
}
