import '../../general_exports.dart';

class ProjectUnitAppBar extends StatelessWidget {
  const ProjectUnitAppBar({
    super.key,
    this.showFollow = true,
    this.isFollowed = false,
    this.follow,
    this.shareText,
    this.shareTitle,
  });

  final bool showFollow;
  final bool isFollowed;
  final Function()? follow;
  final String? shareText;
  final String? shareTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DEVICE_HEIGHT * 0.15,
      color: const Color(AppColors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_WIDTH * 0.04,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(AppColors.white),
                          borderRadius:
                              BorderRadius.circular(DEVICE_HEIGHT * 0.008),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(DEVICE_HEIGHT * 0.008),
                          child: RotatedBox(
                              quarterTurns: isRTL ? 2 : 0,
                              child: SvgPicture.asset(iconArrowBack)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: DEVICE_WIDTH * 0.03,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_WIDTH * 0.04,
                ),
                child: Row(
                  children: [
                    if (showFollow)
                      GestureDetector(
                        onTap: follow,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(
                              !isFollowed ? AppColors.white : AppColors.primary,
                            ),
                            borderRadius:
                                BorderRadius.circular(DEVICE_HEIGHT * 0.008),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(DEVICE_HEIGHT * 0.008),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: DEVICE_WIDTH * 0.02,
                                  ),
                                  SvgPicture.asset(
                                    !isFollowed ? iconFavorite : iconFollowing,
                                  ),
                                  SizedBox(
                                    width: DEVICE_WIDTH * 0.02,
                                  ),
                                  MadaText(
                                    !isFollowed ? 'follow' : 'following',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(),
                                  ),
                                  SizedBox(
                                    width: DEVICE_WIDTH * 0.02,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    SizedBox(
                      width: DEVICE_WIDTH * 0.02,
                    ),
                    if (shareText != null)
                      GestureDetector(
                        onTap: () {
                          Share.share('$shareTitle\n$shareText');
                        },
                        child: Container(
                          width: DEVICE_WIDTH * 0.085,
                          decoration: BoxDecoration(
                            color: const Color(AppColors.white),
                            borderRadius:
                                BorderRadius.circular(DEVICE_HEIGHT * 0.008),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(DEVICE_HEIGHT * 0.008),
                            child: SvgPicture.asset(iconShare),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.01,
          ),
        ],
      ),
    );
  }
}
