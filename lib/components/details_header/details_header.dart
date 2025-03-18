import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    required this.title,
    this.onDownloadPdfPressed,
    this.onSharePressed,
    this.onFollowPressed,
    this.showFollow = true,
    this.showShareIcon = true,
    this.showDownloadPdfIcon = true,
    this.isFollowed = false,
    super.key,
  });

  final String title;
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
              child: IconButton(
                iconSize: 70.h,
                icon: SvgPicture.asset(
                  iconBack,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
            ),
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
                    color: FlutterMadaTheme.of(context)
                        .color97BE5A
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    spacing: 10.w,
                    children: [
                      SvgPicture.asset(
                        iconFavorite,
                        height: 40.h,
                      ),
                      Text(
                        FFLocalizations.of(context).getText('follow'),
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
