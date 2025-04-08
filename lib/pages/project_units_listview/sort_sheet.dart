import '../../general_exports.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({
    super.key,
    this.onSelectSortKey,
    this.onSelectSortType,
    this.onApply,
    this.isProjectSort = false,
  });

  final dynamic onSelectSortType;
  final Function(dynamic item)? onSelectSortKey;
  final Function()? onApply;
  final bool isProjectSort;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectUnitsListviewModel>(
      builder: (
        BuildContext context,
        ProjectUnitsListviewModel model,
        Widget? child,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  FFLocalizations.of(context)
                      .getText('please_select_the_sorting'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.02,
                ),
                SelectList(
                  isWrap: true,
                  items: isProjectSort
                      ? projectSortList(context)
                      : sortList(context),
                  selectedItem: model.selectedTemSortKey,
                  onTap: (dynamic item) {
                    onSelectSortKey!(item);
                  },
                  borderColor: const Color(AppColors.green2),
                  unselectedBackgroundColor: const Color(AppColors.gray),
                  borderWidth: 1,
                ),
                if (model.selectedTemSortKey != null &&
                    (model.selectedTemSortKey['key'] == 'price' ||
                        model.selectedTemSortKey['key'] == 'startingPrice'))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText('price'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.01,
                      ),
                      SelectList(
                        isWrap: true,
                        items: priceSortList(context),
                        selectedItem: model.selectedTemSortType,
                        onTap: (dynamic item) {
                          onSelectSortType!(item);
                        },
                        borderColor: const Color(AppColors.green2),
                        unselectedBackgroundColor: const Color(AppColors.gray),
                        borderWidth: 1,
                      ),
                    ],
                  )
                else if (model.selectedTemSortKey != null &&
                    model.selectedTemSortKey['key'] == 'createdAt')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText('newest'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.01,
                      ),
                      SelectList(
                        isWrap: true,
                        items: createdAtSortList(context),
                        selectedItem: model.selectedTemSortType,
                        onTap: (dynamic item) {
                          onSelectSortType!(item);
                        },
                        borderColor: const Color(AppColors.green2),
                        unselectedBackgroundColor: const Color(AppColors.gray),
                        borderWidth: 1,
                      ),
                    ],
                  ),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.03,
                ),
              ],
            ),
            CustomButton(
              text: FFLocalizations.of(context).getText('apply'),
              onPressed: onApply,
            )
          ],
        );
      },
    );
  }
}

List<dynamic> sortList(BuildContext context) {
  return [
    {
      'key': 'price',
      'value': FFLocalizations.of(context).getText('price'),
    },
    {
      'key': 'createdAt',
      'value': FFLocalizations.of(context).getText('newest'),
    }
  ];
}

List<dynamic> projectSortList(BuildContext context) {
  return [
    {
      'key': 'startingPrice',
      'value': FFLocalizations.of(context).getText('starting_price'),
    },
    {
      'key': 'createdAt',
      'value': FFLocalizations.of(context).getText('newest'),
    },
  ];
}

List<dynamic> priceSortList(BuildContext context) {
  return [
    {
      'key': 'asc',
      'value': FFLocalizations.of(context).getText('low_to_high'),
    },
    {
      'key': 'desc',
      'value': FFLocalizations.of(context).getText('high_to_low'),
    }
  ];
}

List<dynamic> createdAtSortList(BuildContext context) {
  return [
    {
      'key': 'asc',
      'value': FFLocalizations.of(context).getText('oldest_to_newest'),
    },
    {
      'key': 'desc',
      'value': FFLocalizations.of(context).getText('newest_to_oldest'),
    }
  ];
}
