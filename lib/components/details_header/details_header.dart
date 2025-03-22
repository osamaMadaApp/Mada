import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    this.onDownloadPdfPressed,
    this.onSharePressed,
    this.onFollowPressed,
    this.showFollow = true,
    this.showShareIcon = true,
    this.showDownloadPdfIcon = true,
    this.isFollowed = false,
    super.key,
  });

  final bool showShareIcon;
  final bool showDownloadPdfIcon;
  final bool showFollow;
  final bool isFollowed;
  final Function()? onDownloadPdfPressed;
  final Function()? onSharePressed;
  final Function()? onFollowPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 20.w,
          children: [
            RotatedBox(
              quarterTurns: FFAppState().getSelectedLanguge() == 'ar' ? 2 : 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  iconBack,
                  height: 70.h,
                ),
              ),
            ),
            // Text(
            //   title,
            //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600,
            //       ),
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
        Row(
          spacing: 10.w,
          children: [
            if (showFollow)
              GestureDetector(
                onTap: onFollowPressed,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: !isFollowed
                        ? FlutterMadaTheme.of(context)
                            .color97BE5A
                            .withValues(alpha: 0.1)
                        : const Color(AppColors.primary),
                    borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.008),
                  ),
                  child: Row(
                    spacing: 10.w,
                    children: [
                      SvgPicture.asset(
                        !isFollowed ? iconFavorite : iconFollowing,
                        height: 40.h,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          !isFollowed ? 'follow' : 'following',
                        ),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            if (showDownloadPdfIcon)
              GestureDetector(
                onTap: onDownloadPdfPressed,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: FlutterMadaTheme.of(context)
                        .color97BE5A
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    spacing: 10.w,
                    children: [
                      SvgPicture.asset(
                        iconDownloadPdf,
                        height: 40.h,
                      ),
                      Text(
                        FFLocalizations.of(context)
                            .getText('download_property_pdf'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            if (showShareIcon)
              GestureDetector(
                onTap: onSharePressed,
                child: SvgPicture.asset(
                  iconGreenShare,
                  height: 78.h,
                ),
              )
          ],
        ),
      ],
    );
  }
}
