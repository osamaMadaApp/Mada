import '../../general_exports.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<VideoScreenModel>(
      create: (BuildContext context) => VideoScreenModel(),
      child: VideoWidget(
        videoUrl: args?[keyUrl],
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    required this.videoUrl,
    super.key,
  });
  final String videoUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoScreenModel>(context, listen: false).onInit(
        widget.videoUrl,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoScreenModel>(
      builder: (
        BuildContext context,
        VideoScreenModel controller,
        Widget? child,
      ) {
        if (controller.videoController == null ||
            !controller.videoController!.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: <Widget>[
              Center(
                child: AspectRatio(
                  aspectRatio: controller.videoController!.value.aspectRatio,
                  child: CachedVideoPlayer(controller.videoController!),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: DEVICE_HEIGHT * 0.06,
                    left: DEVICE_WIDTH * 0.02,
                    right: DEVICE_WIDTH * 0.02,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
              Positioned(
                bottom: DEVICE_HEIGHT * 0.01,
                left: 0,
                right: 0,
                child: VideoPlayerControls(controller.videoController!),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VideoPlayerControls extends StatelessWidget {
  const VideoPlayerControls(
    this.videoController, {
    super.key,
    this.withOptions = true,
  });
  final CachedVideoPlayerController videoController;
  final bool withOptions;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: videoController,
      builder:
          (BuildContext context, CachedVideoPlayerValue value, Widget? child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              Slider(
                allowedInteraction: SliderInteraction.tapAndSlide,
                value: value.position.inSeconds.toDouble(),
                activeColor: const Color(AppColors.white),
                thumbColor: Color(
                  withOptions ? AppColors.white : AppColors.transparent,
                ),
                onChanged: (double value) {
                  videoController.seekTo(Duration(seconds: value.toInt()));
                },
                max: value.duration.inSeconds.toDouble(),
              ),
              if (withOptions)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.04,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              videoController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              videoController.value.isPlaying
                                  ? videoController.pause()
                                  : videoController.play();
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              videoController.value.volume == 0
                                  ? Icons.volume_off
                                  : Icons.volume_up,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              videoController.setVolume(
                                videoController.value.volume == 0 ? 1.0 : 0.0,
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        '${value.position.inMinutes.toString().padLeft(2, '0')}:${(value.position.inSeconds % 60).toString().padLeft(2, '0')} / '
                        '${value.duration.inMinutes.toString().padLeft(2, '0')}:${(value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
