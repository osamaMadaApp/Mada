import '../../general_exports.dart';

class VideoAndBrochure extends StatelessWidget {
  const VideoAndBrochure({
    required this.imageUrl,
    super.key,
    this.showVideo = true,
    this.showBrochure = true,
    this.onVideoTapped,
    this.onViewBrochure,
    this.showUpperGrayLine = false,
    this.showBottomGrayLine = true,
  });

  final bool showVideo;
  final bool showBrochure;
  final Function()? onVideoTapped;
  final Function()? onViewBrochure;
  final String imageUrl;
  final bool showUpperGrayLine;
  final bool showBottomGrayLine;

  @override
  Widget build(BuildContext context) {
    if (showBrochure || showVideo) {
      return Column(
        children: [
          if (showUpperGrayLine) const GrayLine(),
          Padding(
            padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MadaText(
                  showVideo && showBrochure
                      ? FFLocalizations.of(context)
                          .getText('video_and_brochure')
                      : showVideo && !showBrochure
                          ? FFLocalizations.of(context).getText('video')
                          : FFLocalizations.of(context).getText('brochure'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(
                          AppColors.black,
                        ),
                      ),
                ),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.02,
                ),
                Row(
                  spacing: 20.w,
                  children: [
                    if (showVideo)
                      GestureDetector(
                        onTap: onVideoTapped,
                        child: Stack(
                          children: <Widget>[
                            CachedImage(
                              image: imageUrl,
                              borderRadius: DEVICE_WIDTH * 0.005,
                              height: DEVICE_HEIGHT * 0.1,
                              width: DEVICE_WIDTH * 0.1,
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  DEVICE_WIDTH * 0.01,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(AppColors.primary)
                                        .withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      DEVICE_HEIGHT * 0.02,
                                    ),
                                    child: SvgPicture.asset(
                                      iconVideo,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (showBrochure)
                      Container(
                        width: 2.w,
                        height: 140.h,
                        decoration: const BoxDecoration(
                          color: Color(AppColors.gray5),
                        ),
                      ),
                    if (showBrochure)
                      GestureDetector(
                        onTap: onViewBrochure,
                        child: Row(
                          children: [
                            Container(
                              height: DEVICE_HEIGHT * 0.1,
                              width: DEVICE_WIDTH * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  DEVICE_HEIGHT * 0.01,
                                ),
                                color: const Color(AppColors.gray5),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MadaText(
                                      FFLocalizations.of(context)
                                          .getText('view_brochure'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: const Color(
                                              AppColors.black,
                                            ),
                                          ),
                                    ),
                                    SvgPicture.asset(
                                      iconBrouchure,
                                      height: DEVICE_HEIGHT * 0.05,
                                      width: DEVICE_WIDTH * 0.05,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: DEVICE_WIDTH * 0.02,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.02,
          ),
          if (showBottomGrayLine)
            Column(
              children: [
                const GrayLine(),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.02,
                ),
              ],
            )
        ],
      );
    } else {
      return const Center();
    }
  }
}
