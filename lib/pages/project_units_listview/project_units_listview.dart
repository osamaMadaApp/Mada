import '../../app_state.dart';
import '../../components/status_tag/status_tag.dart';
import '../../general_exports.dart';

class ProjectUnitsListviewScreen extends StatelessWidget {
  const ProjectUnitsListviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider<ProjectUnitsListviewModel>(
      create: (BuildContext context) => ProjectUnitsListviewModel(),
      child: ProjectUnitsListview(
        projectId: args?[keyProjectId],
      ),
    );
  }
}

class ProjectUnitsListview extends StatefulWidget {
  const ProjectUnitsListview({
    super.key,
    this.projectId,
  });

  final dynamic projectId;

  @override
  State<ProjectUnitsListview> createState() =>
      _ProjectUnitsListviewWidgetState();
}

class _ProjectUnitsListviewWidgetState extends State<ProjectUnitsListview> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ProjectUnitsListviewModel>(context, listen: false)
          .initState(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectUnitsListviewModel>(
      builder: (
        BuildContext context,
        ProjectUnitsListviewModel model,
        Widget? child,
      ) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: MadaHeader(
              title: FFLocalizations.of(context).getText('project_units'),
              actions: [
                HeaderContainer(
                  onPressed: () {
                    model.onSortPressed(context);
                  },
                  icon: iconSort,
                ),
                SizedBox(width: DEVICE_WIDTH * 0.02),
                HeaderContainer(
                  onPressed: () {
                    model.openCustomFilterBottomSheet(context);
                  },
                  icon: iconCustomFilter,
                ),
                SizedBox(width: DEVICE_WIDTH * 0.02),
              ],
            ),
            key: scaffoldKey,
            // backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: model.onRefresh,
              color: FlutterMadaTheme.of(context).primary,
              child: model.data == null
                  ? const Center()
                  : Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              RefreshIndicator(
                                onRefresh: model.onRefresh,
                                color: FlutterMadaTheme.of(context).primary,
                                backgroundColor: Colors.white,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: DEVICE_WIDTH * 0.02,
                                          vertical: DEVICE_HEIGHT * 0.02,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${FFLocalizations.of(context).getText('available_units')} ( ${model.getTotalNumberOfUnits() ?? 0} )',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    StatusTag(
                                                      color: const Color(
                                                          0xff97be5a),
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText('available'),
                                                      isSelected: model
                                                              .availableSelected ??
                                                          false,
                                                      onTap: () {
                                                        model.makeAvailableSelected();
                                                        model.makeAvailableSelectedList();
                                                      },
                                                    ),
                                                    StatusTag(
                                                      color: const Color(
                                                          0xffFD9B63),
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText('reserved'),
                                                      isSelected: model
                                                              .bookedSelected ??
                                                          false,
                                                      onTap: () {
                                                        model.makeBookedSelected();
                                                        model.makeBookedSelectedList();
                                                      },
                                                    ),
                                                    StatusTag(
                                                      color: const Color(
                                                          0xffFF0000),
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText('soldOut'),
                                                      isSelected:
                                                          model.soldSelected ??
                                                              false,
                                                      onTap: () {
                                                        model
                                                            .makeSoldSelected();
                                                        model
                                                            .makeSoldSelectedList();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: DEVICE_HEIGHT * 0.02),
                                            Column(
                                              children: [
                                                if (model.data[keyResults]
                                                        .isEmpty &&
                                                    !model.isLoading)
                                                  SizedBox(
                                                    height: DEVICE_HEIGHT * 0.6,
                                                    child: Center(
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'no_data_found',
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  const UnitsList()
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
    this.onPressed,
    this.icon,
  });

  final Function()? onPressed;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        padding: EdgeInsets.all(DEVICE_WIDTH * 0.01),
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: const Color(AppColors.green3).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          icon ?? '',
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class UnitsList extends StatelessWidget {
  const UnitsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectUnitsListviewModel>(
      builder: (
        BuildContext context,
        ProjectUnitsListviewModel model,
        Widget? child,
      ) {
        return Column(
          children: [
            ...getValues(model).map(
              (dynamic item) {
                final List<dynamic> units = item[keyUnits];
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: DEVICE_HEIGHT * 0.02,
                    horizontal: DEVICE_WIDTH * 0.02,
                  ),
                  margin: EdgeInsets.only(
                    bottom: DEVICE_HEIGHT * 0.01,
                  ),
                  width: DEVICE_WIDTH,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item[keyID],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...units.map(
                              (dynamic unit) {
                                return HorizontalProjectUnitCard(
                                  item: unit,
                                  showUnitNumber: true,
                                  maxLines: 3,
                                  showBathroom: unit[keyUnitType] != 'Land',
                                  showBedroom: unit[keyUnitType] != 'Land',
                                  onFavoritesPressed: () {
                                    model.favorites(
                                      unit,
                                      context,
                                    );
                                  },
                                  withFavorite: unit[keyStatus] != 'Sold Out',
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.routeUnitDetails,
                                      arguments: {
                                        keyID: unit[keyID],
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  dynamic getValues(ProjectUnitsListviewModel model) {
    if (model.availableSelected == true ||
        model.bookedSelected == true ||
        model.soldSelected == true) {
      return model.savedFilterData;
    } else {
      return model.data[keyResults][keyUnits];
    }
  }
}

class HorizontalProjectUnitCard extends StatelessWidget {
  const HorizontalProjectUnitCard({
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
    this.verticalPadding,
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
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    String orderId = '';
    if (item[keyOrderID] != null) {
      orderId = item[keyOrderID].length > 10
          ? item[keyOrderID].substring(0, 10)
          : item[keyOrderID];
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        margin: EdgeInsets.fromLTRB(
            FFAppState().selectedLangugeAppState == 1 ? 0 : 13,
            0,
            FFAppState().selectedLangugeAppState == 1 ? 13 : 0,
            0),
        decoration: BoxDecoration(
          color: getStatus(item[keyStatus]).withOpacity(0.1),
          border: Border.all(
            color: getStatus(item[keyStatus]),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedImage(
                      image: item[imageKey] != null && item[imageKey].isNotEmpty
                          ? item[imageKey][0]
                          : testImage,
                      borderRadius: 10,
                      width: 110.w,
                      height: 110.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ],
                          ),
                          if (item[keyUnitNumber] != null && showUnitNumber)
                            Text(
                              '- ${item[keyUnitNumber]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          FlutterMadaTheme.of(context).primary),
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
                                        color: FlutterMadaTheme.of(context)
                                            .color989898,
                                      ),
                                ),
                              ],
                            )
                          else
                            const Center(),
                          SizedBox(height: 16.h),
                          Container(
                            width: 160.w,
                            child: SingleChildScrollView(
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
                                                text: label[keyText].toString(),
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
                                        color: FlutterMadaTheme.of(context)
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        child: withFavorite
                            ? GestureDetector(
                                onTap: onFavoritesPressed,
                                child: SvgPicture.asset(
                                  item[keyIsWishListed] == true
                                      ? iconFav
                                      : iconUnFav,
                                ),
                              )
                            : Container(),
                      ),
                    )
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            getUnitOfMeasure(context),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                            color: FlutterMadaTheme.of(context).color989898,
                          ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      '${FFLocalizations.of(context).getText('date')}: ${isoToReadableDate(item[keyCreatedAt])}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                            color: FlutterMadaTheme.of(context).color989898,
                          ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color getStatus(String? status) {
    if (status == 'Available') {
      return const Color(0xff97be5a);
    } else if (status == 'Reserved' || status == 'Booked') {
      return const Color(0xffFD9B63);
    } else {
      return const Color(0xffFF0000);
    }
  }
}
