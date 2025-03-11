import '../../general_exports.dart';

class NotificationsPageModel extends ChangeNotifier {
  NotificationsPageModel() {
    getNotificationsList();
    scrollController.addListener(scrollListener);
  }

  NotificationType selectedScreen = NotificationType.newNotifications;
  bool isLoading = true;
  List<dynamic> notifications = <dynamic>[];
  int page = 0;
  bool hasNextPage = true;
  ScrollController scrollController = ScrollController();
  dynamic selectedNotification;

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (hasNextPage) {
        getNotificationsList(pagination: true);
      }
    }
  }

  void getNotificationsList({
    bool isRead = false,
    int pageSize = 10,
    bool pagination = false,
    bool withLoading = true,
  }) {
    if (withLoading) {
      startLoading();
    }

    ++page;
    if (!pagination) {
      isLoading = true;
    }
    notifyListeners();
    ApiRequest(
      path: apiNotificationsList,
      formatResponse: true,
      defaultHeadersValue: false,
      className: 'NotificationsScreenController/getNotificationsList',
      queryParameters: <String, Object>{
        keyPage: page,
        keyPageSize: pageSize,
        keyIsRead: isRead,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        notifications.addAll(data[keyResults][keyDocs]);
        if (notifications.isNotEmpty) {
          selectedNotification = notifications.first;
        }
        hasNextPage = data[keyResults][keyHasNextPage];
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void onChangeCategoryPress(
    NotificationType category, {
    bool withLoading = true,
    bool refresh = false,
  }) {
    if (category != selectedScreen || refresh) {
      selectedScreen = category;
      notifications.clear();
      page = 0;
      getNotificationsList(
        isRead:
            selectedScreen == NotificationType.newNotifications ? false : true,
        withLoading: withLoading,
      );
    }

    notifyListeners();
  }

  Future<void> onRefresh() async {
    onChangeCategoryPress(selectedScreen, refresh: true);
  }

  void onNotificationPress(dynamic newValue) {
    selectedNotification = newValue;
    consoleLogPretty(newValue);
    notifyListeners();
  }
}

enum NotificationType {
  newNotifications,
  readNotifications,
}
