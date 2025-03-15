import '../../general_exports.dart';

class ExclusiveProjectsModel extends ChangeNotifier{

  ExclusiveProjectsModel() {
    initState();
  }

  final List<dynamic> lastProjects = [];
  Map<String, dynamic> data = {};
  List<dynamic> menu = [];
  bool isLoading = true;
  int page = 0;
  ScrollController scrollController = ScrollController();
  bool hasNextPage = true;
  void initState() {
    getExclusiveProjects(hideScreen: true);
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (hasNextPage) {
        getExclusiveProjects();
      }
    }
  }

  void getExclusiveProjects({bool hideScreen = false}) {
    if (hideScreen) {
      isLoading = true;
      notifyListeners();
    }

    ++page;
    startLoading();
    ApiRequest(
      path: apiExclusiveProjects,
      formatResponse: true,
      defaultHeadersValue: false,
      method: ApiMethods.post,
      className: 'ExclusiveProjectsController/getExclusiveProjects',
      body: {
        keyPage: page,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        // Only for the first time
        if (this.data.isEmpty) {
          this.data = data;
          menu = data[keyResults][keyMenu];
        }
        lastProjects.addAll(data[keyResults][keyFinalData][keyDocs]);
        hasNextPage = data[keyResults][keyFinalData][keyHasNextPage];
        isLoading = false;
        notifyListeners();
        consoleLog(lastProjects.length, key: 'length');
      },
    );
  }

  Future<void> onRefresh() async {
    lastProjects.clear();
    page = 0;
    hasNextPage = true;
    data = {};
    getExclusiveProjects(hideScreen: true);
  }
}
