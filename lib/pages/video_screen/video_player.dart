// import 'package:video_cached_player/video_cached_player.dart';

// import '../../general_exports.dart';

// class VideoScreen extends StatelessWidget {
//   const VideoScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VideoScreenController>(
//       init: VideoScreenController(),
//       builder: (VideoScreenController controller) {
//         return Scaffold(
//           backgroundColor: Colors.black,
//           body: Stack(
//             children: <Widget>[
//               Center(
//                 child: AspectRatio(
//                   aspectRatio: controller.videoController.value.aspectRatio,
//                   child: CachedVideoPlayer(
//                     controller.videoController,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     top: DEVICE_HEIGHT * 0.06,
//                     left: DEVICE_WIDTH * 0.02,
//                     right: DEVICE_WIDTH * 0.02,
//                   ),
//                   child: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 36.0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: DEVICE_HEIGHT * 0.01,
//                 left: 0,
//                 right: 0,
//                 child: VideoPlayerControls(controller.videoController),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
