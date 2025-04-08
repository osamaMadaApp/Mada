import 'package:country_flags/country_flags.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuPageModel(),
      child: const Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuPageModel menuPageModel = Provider.of<MenuPageModel>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        FFLocalizations.of(context).getText('menu'),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          color: FlutterMadaTheme.of(context).color292D32,
                          fontFamily: AppFonts.workSans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        FFLocalizations.of(context).getText('mada_properties'),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: AppFonts.workSans,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    // onTap: onCountryChange,
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
              ),
              SizedBox(height: 55.h),
              SizedBox(
                height: MediaQuery.of(context).size.height - 250.h,
                child: CustomTabs(
                  tabs: <TabItem>[
                    TabItem(
                      label:
                          FFLocalizations.of(context).getText('view_profile'),
                      icon: iconViewProfile,
                      content: const ViewProfileScreen(),
                    ),
                    TabItem(
                      label: FFLocalizations.of(context).getText('favorites'),
                      icon: iconLovely,
                      content: const Center(
                        child: FavoritesScreen(),
                      ),
                    ),
                    TabItem(
                      label: FFLocalizations.of(context).getText('contact_us'),
                      icon: iconCallCalling,
                      content: const ContactUsScreen(),
                    ),
                    TabItem(
                      label: FFLocalizations.of(context)
                          .getText('terms_and_conditions'),
                      icon: iconJudge,
                      content: const TermsAndCOnditions(),
                    ),
                    TabItem(
                      label: FFLocalizations.of(context)
                          .getText('fal_license_awards'),
                      icon: iconFAL,
                      content: FALLicenseAndAwards(
                        sliderSettings: menuPageModel.sliderSettings,
                        banners: menuPageModel.bannerImages,
                      ),
                    ),
                  ],
                  tabController: menuPageModel.tabController,
                  onTabChanged: menuPageModel.changeTab,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
