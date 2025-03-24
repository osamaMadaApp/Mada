import 'package:flutter_svg/flutter_svg.dart';

import '../../general_exports.dart';

class UnitLayoutIcon extends StatelessWidget {
  const UnitLayoutIcon({super.key, this.planImage, this.onTap});

  final String? planImage;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            MadaText(
              FFLocalizations.of(context).getText('unit_layout'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(
                      AppColors.black,
                    ),
                  ),
            ),
            SizedBox(height: 49.h,),
            Row(
              children: [
                Container(
                  width: 88.w,
                  height: 88.h,
                  decoration: BoxDecoration(
                    color: FlutterMadaTheme.of(context).colorFAFAFA,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: CachedImage(
                      width: 56.w,
                      height: 56.h,
                      borderRadius: 8,
                      fit: BoxFit.cover,
                      image: planImage,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.02,
                    vertical: DEVICE_HEIGHT * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MadaText(
                        FFLocalizations.of(context).getText('view_unit_layout'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(
                                AppColors.black,
                              ),
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      MadaText(
                        FFLocalizations.of(context)
                            .getText('click_to_show_details'),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(AppColors.gray2),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
