import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<MenuPageModel>(
          create: (BuildContext context) => MenuPageModel(),
        ),
      ],
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
          horizontal: 15.w,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.only(
                left: isRTL ? 30.w : 0.w,
                right: !isRTL ? 30.w : 0.w,
              ),
              child: HeaderWidget(
                title: FFLocalizations.of(context).getText('menu'),
                subTitle:
                    FFLocalizations.of(context).getText('mada_properties'),
                showProfilePic: false,
              ),
            ),
            SizedBox(height: 55.h),
            SizedBox(
              height: MediaQuery.of(context).size.height - 250.h,
              child: CustomTabs(
                tabs: <TabItem>[
                  TabItem(
                    label: FFLocalizations.of(context).getText('view_profile'),
                    icon: iconViewProfile,
                    content: const ViewProfile(),
                  ),
                  TabItem(
                    label: FFLocalizations.of(context).getText('favorites'),
                    icon: iconLovely,
                    content: const Center(
                      child: Text('Search Page'),
                    ),
                  ),
                  TabItem(
                    label: FFLocalizations.of(context).getText('contact_us'),
                    icon: iconCallCalling,
                    content: const Center(
                      child: Text('Profile Page'),
                    ),
                  ),
                  TabItem(
                    label: FFLocalizations.of(context)
                        .getText('terms_and_conditions'),
                    icon: iconJudge,
                    content: const Center(
                      child: Text('Profile Page'),
                    ),
                  ),
                  TabItem(
                    label: FFLocalizations.of(context)
                        .getText('fal_license_awards'),
                    icon: iconFAL,
                    content: const Center(
                      child: Text('Profile Page'),
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
    );
  }
}
