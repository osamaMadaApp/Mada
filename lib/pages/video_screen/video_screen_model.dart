// import 'package:flutter/services.dart';
// import 'package:video_cached_player/video_cached_player.dart';

// import '../../general_exports.dart';

// class VideoScreenController extends ChangeNotifier {
//   CachedVideoPlayerController videoController =
//       CachedVideoPlayerController.network(
//     Get.arguments[keyVideoUrl] ??
//         'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
//     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//   );

//   bool isLoading = true;

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     await SystemChrome.setPreferredOrientations(
//       <DeviceOrientation>[
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ],
//     );
//     startVideoPlayer();
//   }

//   Future<void> startVideoPlayer() async {
//     try {
//       await videoController.initialize().then((value) {
//         if (videoController.value.isInitialized) {
//           isLoading = false;
//         } else if (videoController.value.isBuffering) {
//           isLoading = true;
//         }
//         videoController.play();
//         update();
//       });
//     } catch (error) {
//       print('Error initializing video player: $error');
//     }
//   }

//   Future<void> onPop() async {
//     videoController.pause();
//     videoController.dispose();
//     await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     onPop();
//   }
// }
