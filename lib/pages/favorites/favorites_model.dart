import '../../general_exports.dart';

class FavoritesModel extends ChangeNotifier {
  GeneralTaps selectedCategory = GeneralTaps.exclusiveUnits;

  bool isLoading = true;
  List<dynamic> units = [];
  int page = 0;
  bool hasNextPage = true;
  ScrollController scrollController = ScrollController();

  void addScrollListener() {
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (hasNextPage) {
        getFavoriteList(pagination: true);
      }
    }
  }

  void getFavoriteList({
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
      path: apiGetWishListData,
      formatResponse: true,
      className: 'FavoritesScreenController/getFavoriteList',
      queryParameters: {
        keyType: type,
        keyPage: page,
        keyPageSize: pageSize,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();

        units.addAll(data[keyResults][keyFinalData][keyDocs]);
        hasNextPage = data[keyResults][keyFinalData][keyHasNextPage];
        isLoading = false;
        notifyListeners();
      },
    );
  }

  onChangeCategoryPress(GeneralTaps category, {bool refresh = false}) {
    if (category != selectedCategory || refresh) {
      selectedCategory = category;
      units.clear();
      page = 0;
      getFavoriteList(
        type: selectedCategory == GeneralTaps.exclusiveUnits
            ? 'unit'
            : 'property',
      );
    }

    notifyListeners();
  }

  void addOrRemoveFromFavorite(
    dynamic id,
    PropertyType type, {
    Function()? onRequestSuccess,
    String bodyKey = 'unitId',
    Function()? onSuccessLogin,
  }) {
    startLoading();
    ApiRequest(
      path: type == PropertyType.unit
          ? apiUnitsAddToWishList
          : apiPropertiesAddToWishList,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      className: 'FavoritesScreenController/addOrRemoveFromFavorite',
      body: <String, dynamic>{
        bodyKey: id,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        if (response[keySuccess] == true) {
          onRequestSuccess!();
          notifyListeners();
        }

        showToast(response[keyMessage]);
        dismissLoading();
      },
    );
  }

  Future<void> onRefresh() async {
    onChangeCategoryPress(selectedCategory, refresh: true);
  }
}

enum PropertyType {
  property,
  unit,
}
