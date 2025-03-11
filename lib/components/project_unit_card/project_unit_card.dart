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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: RoundedContainer(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: isRTL ? null : 0,
                        right: isRTL ? 0 : null,
                        child: CachedImage(
                          image: item[imageKey] != null &&
                                  item[imageKey].isNotEmpty
                              ? item[imageKey][0]
                              : testImage,
                          borderRadius: 2.w,
                          width: 35.w,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: isRTL ? 0 : 35.w,
                          right: isRTL ? 35.w : 0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 1.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 3.w,
                                              child: Text(
                                                '${item[keyTitle]}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                maxLines: maxLines,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (item[keyUnitNumber] != null &&
                                                showUnitNumber)
                                              SizedBox(
                                                width: 37.w,
                                                child: Text(
                                                  '- ${item[keyUnitNumber]}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: FlutterMadaTheme
                                                                  .of(context)
                                                              .primary),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                          ],
                                        ),
                                        if (withFavorite)
                                          GestureDetector(
                                            onTap: onFavoritesPressed,
                                            child: SvgPicture.asset(
                                              item[keyIsWishListed] == true
                                                  ? iconFav
                                                  : iconUnFav,
                                            ),
                                          ),
                                      ],
                                    ),
                                    // SizedBox(height: DEVICE_HEIGHT * 0.01),
                                    if (showComAndSub)
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
                                                      .gray600,
                                            ),
                                      )
                                    else
                                      const Center(),
                                    SizedBox(height: 1.h),
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
                                                        textSize: 10,
                                                        textColor: Color(
                                                          int.parse(
                                                            hexToColor(
                                                              label[keyTextColor] ??
                                                                  '#FFFFFF',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      )
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
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    if (item[keyPrice] != null)
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2.w),
                        bottomRight: Radius.circular(2.w),
                      ),
                      color: FlutterMadaTheme.of(context).gray600,
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  getUnitOfMeasure(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 11,
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
                              SizedBox(width: 5.w),
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
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (showBathroom)
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5.w),
                              SvgPicture.asset(iconBathrooms),
                              SizedBox(width: 2.w),
                              Text(
                                item[keyBathrooms].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 11,
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
                        SizedBox(height: 1.h),
                        ContactUsButtons(
                          containerHeight: 5.h,
                          whatsappNumber: item[keyWhatsappNumber],
                          phoneNumber: item[keyPhoneNumber],
                          showWhatsApp: item[keyWhatsappNumber] != null,
                          whatsappMsg: whatsAppMsg,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        if (item[keyOrderID] != null && showOrderId)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 42.w,
                  child: Text(
                    '${'order_id'.tr}: #${item[keyOrderID] ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
                SizedBox(width: 5.w),
                SizedBox(
                  width: 42.w,
                  child: Text(
                    '${'date'.tr}: #${item[keyCreatedAt]}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
