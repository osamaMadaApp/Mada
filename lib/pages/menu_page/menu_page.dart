import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../structure_main_flow/flutter_mada_theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageWidgetState();
}

class _MenuPageWidgetState extends State<MenuPage> {
  // late MenuPageModel _model;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   super.initState();
  //   _model = createModel(context, () => MenuPageModel());
  //   SchedulerBinding.instance.addPostFrameCallback((_) async {});
  // }

  // @override
  // void dispose() {
  //   _model.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterMadaTheme.of(context).info,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100.h,
            ),
            Expanded(
              child: CustomTabs(
                tabs: <TabItem>[
                  TabItem(
                    label: 'Home',
                    icon: Icons.home,
                    content: const Center(
                      child: Text('Home Page'),
                    ),
                  ),
                  TabItem(
                    label: 'Search',
                    icon: Icons.search,
                    content: const Center(
                      child: Text('Search Page'),
                    ),
                  ),
                  TabItem(
                    label: 'Profile',
                    icon: Icons.person,
                    content: const Center(
                      child: Text('Profile Page'),
                    ),
                  ),
                ],
                activeColor: Colors.black,
                inactiveColor: Colors.black54,
                borderRadius: 16.r,
                backgroundColor: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabs extends StatefulWidget {
  const CustomTabs({
    required this.tabs,
    super.key,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.tabHeight = 50,
    this.borderRadius = 12,
    this.isScrollable = false,
    this.showIndicator = true,
    this.indicatorColor = Colors.blue,
    this.backgroundColor = Colors.white,
  });
  final List<TabItem> tabs;
  final Color activeColor;
  final Color inactiveColor;
  final double tabHeight;
  final double borderRadius;
  final bool isScrollable;
  final bool showIndicator;
  final Color indicatorColor;
  final Color backgroundColor;

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Tab Bar
        Container(
          width: 400.w,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: widget.isScrollable,
            indicator: widget.showIndicator
                ? BoxDecoration(
                    color: widget.indicatorColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  )
                : null,
            labelColor: widget.activeColor,
            unselectedLabelColor: widget.inactiveColor,
            tabs: widget.tabs
                .map(
                  (TabItem tab) => TabItemWidget(tab: tab),
                )
                .toList(),
          ),
        ),

        // Tab Views
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: widget.tabs.map((TabItem tab) => tab.content).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabItem {
  TabItem({required this.label, required this.content, this.icon});
  final String label;
  final IconData? icon;
  final Widget content;
}

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({required this.tab, super.key});
  final TabItem tab;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(tab.icon),
        Text(tab.label),
      ],
    );
  }
}
