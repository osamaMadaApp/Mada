import '../../general_exports.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarModel>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: NavigationRail(
                      selectedIndex: provider.currentIndex,
                      onDestinationSelected: provider.changePage,
                      labelType: NavigationRailLabelType.none,
                      destinations: _buildNavDestinations(context, provider),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                    child: SvgPicture.asset(
                      logo,
                      width: 56.0,
                      height: 56.0,
                    ),
                  )
                ],
              ),
              Expanded(
                child: provider.currentPage,
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
