import '../../general_exports.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    // this.onCountryChange,
    this.profilePicture,
    this.firstName,
  });

  // final Function()? onCountryChange;
  final String? profilePicture;
  final String? firstName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            if (profilePicture != null && profilePicture!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                child: SizedBox(
                  height: 45.w,
                  width: 45.w,
                  child: CachedImage(image: profilePicture),
                ),
              )
            else
              Container(
                width: 0.15.w,
                height: 0.07.h,
                decoration: BoxDecoration(
                  color: FlutterMadaTheme.of(context).info,
                  borderRadius: BorderRadius.circular(0.01.h),
                ),
                child: Center(
                  child: GestureDetector(
                    child: Image.asset(imageUser),
                  ),
                ),
              ),
            SizedBox(width: 0.04.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MadaText(
                  firstName != null
                      ? '${'hi'.tr}, ${firstName!.capitalize ?? ''}'
                      : 'hi_guest'.tr,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: FlutterMadaTheme.of(context).info,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ],
        ),
        // Positioned(
        //   right: !isRTL ? 0.06.w : null,
        //   left: isRTL ? 0.06.w : null,
        //   top: 0.08.h,
        //   child: GestureDetector(
        //     onTap: onCountryChange,
        //     child: Container(
        //       width: 0.15.w,
        //       height: 0.07.h,
        //       decoration: BoxDecoration(
        //         color: Colors.transparent,
        //         borderRadius: BorderRadius.circular(0.01.h),
        //       ),
        //       padding: EdgeInsets.symmetric(
        //         vertical: 0.018.h,
        //         horizontal: 0.025.w,
        //       ),
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(0.01.w),
        //         child: CountryFlag.fromCountryCode(
        //           myAppController.appCountry,
        //           height: 0.02.h,
        //           width: 0.07.w,
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
