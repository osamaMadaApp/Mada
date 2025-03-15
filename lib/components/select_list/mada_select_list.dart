import '../../general_exports.dart';

class SelectList extends StatelessWidget {
  const SelectList({
    required this.items,
    this.minHeight,
    this.minWidth,
    this.textKey = keyValue,
    this.selectedItem,
    this.onTap,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.defaultBorderColor = Colors.transparent,
    this.unselectedBackgroundColor,
    this.unselectedFontColor = Colors.black,
    super.key,
    this.spaceBetween = false,
    this.textWidth,
    this.borderRadius = 0.1,
    this.suffix,
    this.isWrap = false,
    this.showImage = true,
    this.scrollController,
    this.withLimitation = false,
    this.keys,
    this.showCount = false,
    this.suffixWidget,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  final List<dynamic> items;
  final String textKey;
  final Function? onTap;
  final dynamic selectedItem;
  final double borderWidth;
  final bool showImage;
  final bool withLimitation;

  /// The border color of the selected item.
  final Color borderColor;

  /// The default border color of the item.
  final Color defaultBorderColor;
  final Color? unselectedBackgroundColor;
  final Color unselectedFontColor;
  final double? minHeight;
  final double? minWidth;
  final bool spaceBetween;
  final double? textWidth;
  final double? borderRadius;
  final Widget? suffix;
  final bool isWrap;
  final ScrollController? scrollController;
  final List<GlobalKey>? keys;
  final bool showCount;
  final Widget? suffixWidget;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return isWrap
        ? Wrap(
            children: [
              if (withLimitation)
                ..._buildItemWithLimitation(
                  items,
                  context,
                  isWrap,
                  showImage,
                  showCount ? 7 : 14,
                )
              else
                ..._buildItem(items, context, isWrap, showImage),
            ],
          )
        : SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (withLimitation)
                  ..._buildItemWithLimitation(
                    items,
                    context,
                    isWrap,
                    showImage,
                    showCount ? 7 : 14,
                  )
                else
                  ..._buildItem(items, context, isWrap, showImage),
                if (suffixWidget != null) suffixWidget!,
              ],
            ),
          );
  }

  List<Widget> _buildItem(
    dynamic item,
    BuildContext context,
    bool isWrap,
    bool showImage,
  ) {
    return items.map(
      (dynamic item) {
        final bool isSelected = selectedItem is List
            ? selectedItem.contains(item)
            : (selectedItem == item || areMapsEqual(selectedItem, item));
        return Column(
          key: keys != null ? keys![items.indexOf(item)] : null,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RoundedContainer(
                  borderRadius: borderRadius ?? 0.1,
                  borderWidth: borderWidth,
                  minHeight: minHeight ?? DEVICE_HEIGHT * 0.0001,
                  minWidth: minWidth,
                  borderColor: isSelected ? borderColor : defaultBorderColor,
                  color: isSelected
                      ? FlutterMadaTheme.of(context)
                          .color97BE5A
                          .withOpacity(0.15)
                      : (unselectedBackgroundColor?? FlutterMadaTheme.of(context).colorD2D2D2),
                  onTap: () {
                    onTap?.call(item);
                  },
                  child: Column(
                    mainAxisAlignment:
                        mainAxisAlignment ?? MainAxisAlignment.center,
                    crossAxisAlignment:
                        crossAxisAlignment ?? CrossAxisAlignment.start,
                    children: <Widget>[
                      if (item[keyImage] != null && showImage)
                        CachedImage(
                          image: item[keyImage],
                          width: DEVICE_WIDTH * 0.09,
                          height: DEVICE_HEIGHT * 0.0525,
                          borderRadius: DEVICE_WIDTH * 0.01,
                          fit: BoxFit.contain,
                        ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          spaceBetween ? DEVICE_WIDTH * 0.075 : 12.w,
                          16.h,
                          spaceBetween ? DEVICE_WIDTH * 0.075 : 12.w,
                          16.h,
                        ),
                        child: Align(
                          child: Row(
                            children: [
                              SizedBox(
                                width: textWidth,
                                child: Text(
                                  item is String ? item : item[textKey] ?? '',
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: isSelected
                                            ? FlutterMadaTheme.of(context)
                                                .color000000
                                            : unselectedFontColor,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              if (suffix != null) suffix!,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.02),
              ],
            ),
            if (isWrap) SizedBox(height: DEVICE_WIDTH * 0.03),
          ],
        );
      },
    ).toList();
  }

  List<Widget> _buildItemWithLimitation(dynamic item, BuildContext context, bool isWrap, bool showImage, int maxTextLength) {
    List<Widget> rows = [];
    int itemsPerRow;

    for (int i = 0; i < items.length;) {
      // Determine the number of items per row based on the length of the text
      itemsPerRow = 3; // Default to 3 items per row
      for (int j = 0; j < 3 && i + j < items.length; j++) {
        final dynamic item = items[i + j];
        if (item[textKey] != null &&
            item[textKey].toString().length > maxTextLength) {
          itemsPerRow = 2; // If any item's text is too long, limit to 2 items
          break;
        }
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List<Widget>.generate(itemsPerRow, (index) {
            if (i + index < items.length) {
              final dynamic item = items[i + index];
              final bool isSelected = selectedItem is List
                  ? selectedItem.contains(item)
                  : (selectedItem == item || areMapsEqual(selectedItem, item));
              return Column(
                key: keys != null ? keys![items.indexOf(item)] : null,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: DEVICE_WIDTH * 0.009,
                    ),
                    child: RoundedContainer(
                      borderRadius: borderRadius ?? 0.1,
                      borderWidth: borderWidth,
                      minHeight: minHeight ?? DEVICE_HEIGHT * 0.0001,
                      minWidth: minWidth,
                      borderColor:
                          isSelected ? borderColor : defaultBorderColor,
                      color: isSelected
                          ? FlutterMadaTheme.of(context)
                              .color97BE5A
                              .withOpacity(0.15)
                          : (unselectedBackgroundColor?? FlutterMadaTheme.of(context).colorD2D2D2),
                      onTap: () {
                        onTap?.call(item);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (item[keyImage] != null && showImage)
                            CachedImage(
                              image: item[keyImage],
                              width: DEVICE_WIDTH * 0.09,
                              height: DEVICE_HEIGHT * 0.0525,
                              borderRadius: DEVICE_WIDTH * 0.01,
                              fit: BoxFit.contain,
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  spaceBetween ? DEVICE_WIDTH * 0.075 : 0,
                            ),
                            child: Align(
                              child: SizedBox(
                                width: textWidth,
                                child: Row(
                                  children: [
                                    Text(
                                      item is String
                                          ? item
                                          : item[textKey] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: isSelected
                                                ? FlutterMadaTheme.of(context)
                                                    .color000000
                                                : unselectedFontColor,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (item['propertyCount'] != null &&
                                        showCount)
                                      Text(' ( ${item['propertyCount']} )'),
                                    if (suffix != null) suffix!,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isWrap) SizedBox(height: DEVICE_WIDTH * 0.03),
                ],
              );
            } else {
              return Expanded(child: Container());
            }
          }),
        ),
      );

      rows.add(SizedBox(height: DEVICE_WIDTH * 0.03));
      i += itemsPerRow;
    }

    return rows;
  }
}
