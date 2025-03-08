import 'package:country_flags/country_flags.dart';

import '../../general_exports.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.onCountryChange,
    this.profilePicture,
    this.firstName,
  });

  final Function()? onCountryChange;
  final String? profilePicture;
  final String? firstName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              if (profilePicture != null && profilePicture!.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: SizedBox(
                    height: 50.w,
                    width: 50.w,
                    child: CachedImage(image: profilePicture),
                  ),
                )
              else
                Container(
                  height: 50.w,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: FlutterMadaTheme.of(context).info,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: Image.asset(imageUser),
                    ),
                  ),
                ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MadaText(
                    firstName != null
                        ? '${'hi'.tr}, ${firstName!.capitalize ?? ''}'
                        : 'hi_guest'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: FlutterMadaTheme.of(context).color292D32,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onCountryChange,
          child: Container(
            height: 50.w,
            width: 50.w,
            decoration: BoxDecoration(
              color: FlutterMadaTheme.of(context).colorE6EEF3,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 26.h,
              horizontal: 10.w,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CountryFlag.fromCountryCode(
                'sa',
                // myAppController.appCountry,
              ),
            ),
          ),
        )
      ],
    );
  }
}
