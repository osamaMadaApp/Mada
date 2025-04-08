import 'package:country_flags/country_flags.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.onCountryChange,
    this.profilePicture,
    this.title,
    this.showProfilePic = true,
    this.subTitle,
  });

  final Function()? onCountryChange;
  final String? profilePicture;
  final String? title;
  final bool showProfilePic;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              if (showProfilePic)
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
                      color: Color(0x00FFE6EEF3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: GestureDetector(
                        child: Image.asset(imageUser),
                      ),
                    ),
                  ),
              SizedBox(width: 10.w),
              if (subTitle == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MadaText(
                      title != null
                          ? '${FFLocalizations.of(context).getText('hi')}, ${title!.toUpperCase() ?? ''}'
                          : FFLocalizations.of(context).getText('hi_guest'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: FlutterMadaTheme.of(context).color292D32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MadaText(
                      title != null
                          ? '${FFLocalizations.of(context).getText('hi')}, ${title!.toUpperCase() ?? ''}'
                          : FFLocalizations.of(context).getText('hi_guest'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: FlutterMadaTheme.of(context).color292D32,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MadaText(
                      subTitle ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: FlutterMadaTheme.of(context).color292D32,
                            fontWeight: FontWeight.w400,
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
              ),
            ),
          ),
        )
      ],
    );
  }
}
