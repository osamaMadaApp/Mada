import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class FALLicenseAndAwards extends StatelessWidget {
  const FALLicenseAndAwards({
    required this.sliderSettings,
    required this.banners,
    super.key,
  });
  final List<dynamic> sliderSettings;
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 20.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Column(
          children: [
            if (sliderSettings.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    FFLocalizations.of(context).getText('fal_license'),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                    height: 260.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: sliderSettings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (sliderSettings[index][keyUrl] != null) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.routePdfScreen,
                                  arguments: {
                                    keyUrl: sliderSettings[index][keyUrl],
                                    keyTitle: sliderSettings[index][keyTitle],
                                  },
                                );
                              }
                            },
                            child: Container(
                              width: 250.w,
                              padding: EdgeInsets.all(15.h),
                              decoration: BoxDecoration(
                                color: FlutterMadaTheme.of(context).colorFAFAFA,
                                borderRadius: BorderRadius.circular(
                                  10.r,
                                ),
                              ),
                              child: CachedImage(
                                image: sliderSettings[index][keyBannerImage],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (banners.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: 50.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FFLocalizations.of(context)
                          .getText('awards_achievements'),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    SliderWidget(
                      sliderList: banners,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
