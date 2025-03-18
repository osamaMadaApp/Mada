import '../../general_exports.dart';

class SliderHeader extends StatelessWidget {
  const SliderHeader({
    required this.sliderImages,
    super.key,
    this.showFollow = true,
    this.isFollowed = false,
    this.follow,
    this.showThreeSixty = false,
    this.threeSixtyUrl,
    this.onThreeSixtyPressed,
    this.shareText,
    this.shareTitle,
  });

  final List<dynamic> sliderImages;
  final bool showFollow;
  final bool isFollowed;
  final Function()? follow;
  final bool showThreeSixty;
  final String? threeSixtyUrl;
  final Function()? onThreeSixtyPressed;
  final String? shareText;
  final String? shareTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderComponent(
          items: sliderImages,
          height: DEVICE_HEIGHT * 0.45,
          isOpenImageEnabled: true,
          show360: showThreeSixty,
          onThreeSixtyPressed: onThreeSixtyPressed,
          
        ),
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   top: DEVICE_HEIGHT * 0.04,
        //   child: ProjectUnitAppBar(
        //     showFollow: showFollow,
        //     isFollowed: isFollowed,
        //     follow: follow,
        //     shareText: shareText,
        //     shareTitle: shareTitle,
        //   ),
        // ),
      ],
    );
  }
}
