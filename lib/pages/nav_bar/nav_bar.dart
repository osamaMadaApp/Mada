import '../../general_exports.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NavBarModel(),
      child: const NavBar(),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarModel>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      left: 24, bottom: 24, right: 24, top: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterMadaTheme.of(context).colorFFFFFF,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: NavigationRail(
                            backgroundColor: Colors.transparent,
                            selectedIndex: provider.currentIndex,
                            onDestinationSelected: provider.changePage,
                            labelType: NavigationRailLabelType.none,
                            destinations:
                                _buildNavDestinations(context, provider),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                          child: SvgPicture.asset(
                            logo,
                            height: 56.0,
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                child: provider.getCurrentPage(provider.currentIndex),
              ),
            ],
          ),
        );
      },
    );
  }

  List<NavigationRailDestination> _buildNavDestinations(
    BuildContext context,
    NavBarModel provider,
  ) {
    final List<String> icons = [home, myOrders, notification, menu];
    final List<String> disabledIcons = [
      homeDisabled,
      myOrdersDisabled,
      notificationDisabled,
      menuDisabled
    ];

    return List.generate(4, (index) {
      final bool isSelected = provider.currentIndex == index;
      return NavigationRailDestination(
        icon: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: isSelected
              ? FlutterMadaTheme.of(context).coloreff5e6
              : FlutterMadaTheme.of(context).colorFFFFFF,
          elevation: isSelected ? 4.0 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              isSelected ? icons[index] : disabledIcons[index],
              width: 24.0,
              height: 24.0,
            ),
          ),
        ),
        label: Container(),
      );
    });
  }
}
