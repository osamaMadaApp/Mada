import '../../general_exports.dart';

class VideoScreenModel extends ChangeNotifier {
  CachedVideoPlayerController? videoController;
  bool isLoading = true;

  Future<void> onInit(String videoUrl) async {
    consoleLog(videoUrl, key: 'videoUrl');
    videoController = CachedVideoPlayerController.network(
      videoUrl.isNotEmpty
          ? videoUrl
          : 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    try {
      await videoController!.initialize();
      isLoading = false;
      videoController!.play();
      notifyListeners();
    } catch (error) {
      consoleLog('Error initializing video player: $error');
    }
  }

  Future<void> onPop() async {
    videoController?.pause();
    videoController?.dispose();
  }

  @override
  void dispose() {
    onPop();
    super.dispose();
  }
}
