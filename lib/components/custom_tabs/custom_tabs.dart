import '../../general_exports.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs({
    required this.tabs,
    required this.tabController,
    required this.onTabChanged,
    super.key,
  });

  final List<TabItem> tabs;
  final TabController tabController;
  final void Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TabBar(
          controller: tabController,
          isScrollable: true,
          indicator: const BoxDecoration(),
          labelPadding: EdgeInsets.zero,
          onTap: onTabChanged,
          tabs: List<TabItemWidget>.generate(
            tabs.length,
            (int index) {
              return TabItemWidget(
                tab: tabs[index],
                isSelected: tabController.index == index,
                activeColor:
                    FlutterMadaTheme.of(context).color8EC24D.withOpacity(0.1),
                inactiveColor:
                    FlutterMadaTheme.of(context).colorD2D2D2.withOpacity(0.25),
                borderColor: FlutterMadaTheme.of(context).color8EC24D,
              );
            },
          ),
        ),

        // Tab Views
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: tabs.map((TabItem tab) => tab.content).toList(),
          ),
        ),
      ],
    );
  }
}

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    required this.tab,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.borderColor,
    super.key,
  });
  final TabItem tab;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: isSelected ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? borderColor : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (tab.icon != null)
            SvgPicture.asset(
              tab.icon!,
            ),
          SizedBox(width: 8.w),
          Text(
            tab.label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}

class TabItem {
  TabItem({required this.label, required this.content, this.icon});
  final String label;
  final String? icon;
  final Widget content;
}
