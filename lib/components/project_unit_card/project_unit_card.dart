import '../../general_exports.dart';

class ProjectUnitCard extends StatelessWidget {
  const ProjectUnitCard({
    required this.item,
    super.key,
    this.onTap,
    this.showContactIcons = false,
    this.withFavorite = true,
    this.showBedroom = true,
    this.showBathroom = true,
    this.imageKey = keyImage,
    this.onFavoritesPressed,
    this.showOrderId = false,
    this.showComAndSub = false,
    this.showUnitNumber = false,
    this.maxLines = 2,
    this.whatsAppMsg,
    this.borderColor,
  });

  final dynamic item;
  final Function()? onTap;
  final bool showContactIcons;
  final bool withFavorite;
  final String imageKey;
  final Function()? onFavoritesPressed;
  final bool showOrderId;
  final bool showComAndSub;
  final bool showUnitNumber;
  final bool showBedroom;
  final bool showBathroom;
  final int maxLines;
  final String? whatsAppMsg;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    String orderId = '';
    if (item[keyOrderID] != null) {
      orderId = item[keyOrderID].length > 10
          ? item[keyOrderID].substring(0, 10)
          : item[keyOrderID];
    }

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: RoundedContainer(
            withPadding: false,
            color: Colors.white,
            borderColor: borderColor ?? Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 8.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedImage(
                            image: item[imageKey] != null &&
                                    item[imageKey].isNotEmpty
                                ? item[imageKey][0]
                                : testImage,
                            borderRadius: 10,
                            width: 110.w,
                            height: 110.w,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        child: Text(
                                          '${item[keyTitle]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                          maxLines: maxLines,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          if (withFavorite)
                                            GestureDetector(
                                              onTap: onFavoritesPressed,
                                              child: SvgPicture.asset(
                                                item[keyIsWishListed] == true
                                                    ? iconFav
                                                    : iconUnFav,
                                              ),
                                            ),
                                          SizedBox(height: 1.h),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (item[keyUnitNumber] != null &&
                                      showUnitNumber)
                                    Text(
                                      '- ${item[keyUnitNumber]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  FlutterMadaTheme.of(context)
                                                      .primary),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if (showComAndSub)
                                    Column(
                                      children: [
                                        SizedBox(height: 16.h),
                                        Text(
                                          item[keySubCommunity] != null
                                              ? '${item[keyCommunity] ?? ''} - ${item[keySubCommunity] ?? ''}'
                                              : '${item[keyCommunity] ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    FlutterMadaTheme.of(context)
                                                        .color989898,
                                              ),
                                        ),
                                      ],
                                    )
                                  else
                                    const Center(),
                                  SizedBox(height: 16.h),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        if (item[keyStatusInfo] != null &&
                                            item[keyStatusInfo].isNotEmpty)
                                          ...item[keyStatusInfo].map(
                                            (label) {
                                              if (label[keyText] != null &&
                                                  label[keyText].isNotEmpty) {
                                                return Row(
                                                  children: <Widget>[
                                                    LabelCard(
                                                      text: label[keyText]
                                                          .toString(),
                                                      backgroundColor: Color(
                                                        int.parse(
                                                          hexToColor(
                                                            label[keyBackgroundColor] ??
                                                                '#FFFFFF',
                                                          ),
                                                        ),
                                                      ),
                                                      textSize: 16,
                                                      textColor: Color(
                                                        int.parse(
                                                          hexToColor(
                                                            label[keyTextColor] ??
                                                                '#FFFFFF',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.w)
                                                  ],
                                                );
                                              } else {
                                                return const Center();
                                              }
                                            },
                                          ).toList(),
                                      ],
                                    ),
                                  ),
                                  if (item[keyPrice] != null)
                                    Column(
                                      children: [
                                        SizedBox(height: 16.h),
                                        Text(
                                          '${getFormattedPrice(item[keyPrice].toDouble())} ${getCurrency()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    FlutterMadaTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: FlutterMadaTheme.of(context).colorD2D2D240,
                    ),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(iconArea),
                            SizedBox(width: 2.w),
                            Row(
                              children: <Widget>[
                                Text(
                                  item[keyArea].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  getUnitOfMeasure(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (showBedroom)
                          Row(
                            children: <Widget>[
                              SizedBox(width: 12.w),
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(iconBedrooms),
                                  SizedBox(width: 2.w),
                                  Text(
                                    item[keyBedrooms].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (showBathroom && item[keyBathrooms] != null)
                          Row(
                            children: <Widget>[
                              SizedBox(width: 12.w),
                              SvgPicture.asset(iconBathrooms),
                              SizedBox(width: 2.w),
                              Text(
                                item[keyBathrooms].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (showContactIcons)
                    Column(
                      children: <Widget>[
                        SizedBox(height: 8.h),
                        ContactUsButtons(
                          whatsappNumber: item[keyWhatsappNumber],
                          phoneNumber: item[keyPhoneNumber],
                          showWhatsApp: item[keyWhatsappNumber] != null,
                          whatsappMsg: whatsAppMsg,
                        ),
                      ],
                    ),
                  if (item[keyOrderID] != null && showOrderId)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${FFLocalizations.of(context).getText('order_id')}: #$orderId',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                  color:
                                      FlutterMadaTheme.of(context).color989898,
                                ),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            '${FFLocalizations.of(context).getText('date')}: ${isoToReadableDate(item[keyCreatedAt])}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                  color:
                                      FlutterMadaTheme.of(context).color989898,
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
