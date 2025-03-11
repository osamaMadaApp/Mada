import '../../general_exports.dart';

class MyOrderPageModel extends ChangeNotifier {
  MyOrderPageModel() {
    getMyOrdersUnits();
    scrollController.addListener(scrollListener);
  }

  GeneralTaps selectedCategory = GeneralTaps.exclusiveUnits;
  bool isLoading = true;
  List<dynamic> units = <dynamic>[];
  int page = 0;
  bool hasNextPage = true;
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (hasNextPage) {
        getMyOrdersUnits(pagination: true);
      }
    }
  }

  void getMyOrdersUnits({
    String type = 'unit',
    int pageSize = 10,
    bool pagination = false,
  }) {
    startLoading();
    ++page;
    if (!pagination) {
      isLoading = true;
    }

    notifyListeners();
    ApiRequest(
      path: type == 'unit' ? apiMyOrderUnit : apiMyOrdersProperty,
      formatResponse: true,
      className: 'MyOrdersController/getMyOrdersUnits',
      queryParameters: <String, int>{
        keyPage: page,
        keyPageSize: pageSize,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        units.addAll(data[keyResults][keyDocs]);
        hasNextPage = data[keyResults][keyHasNextPage];
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void onChangeCategoryPress(GeneralTaps category, {bool refresh = false}) {
    if (category != selectedCategory || refresh) {
      selectedCategory = category;
      units.clear();
      page = 0;
      getMyOrdersUnits(
        type: selectedCategory == GeneralTaps.exclusiveUnits
            ? 'unit'
            : 'property',
      );
    }

    notifyListeners();
  }

  Future<void> onRefresh() async {
    onChangeCategoryPress(selectedCategory, refresh: true);
  }
}

enum GeneralTaps {
  exclusiveUnits,
  otherUnits,
}
