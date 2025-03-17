import 'package:flutter/scheduler.dart';

import '../../general_exports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late SearchScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<SearchScreenModel>();
    _model.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    _model = context.watch<SearchScreenModel>();
    _model.setInitialTexts(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: MadaHeader(
            title: FFLocalizations.of(context).getText('search_for_units')),
        key: scaffoldKey,
        // backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: _model.onRefresh,
          color: FlutterMadaTheme.of(context).primary,
          child: _model.isLoading
              ? const Center()
              : Column(
                  children: [
                    // CustomInput(
                    //   hint: FFLocalizations.of(context).getText('search'),
                    //   onChange: (String text) {
                    //     _model.onSearchTextChange(text);
                    //   },
                    //   prefixIcon: Padding(
                    //     padding: EdgeInsets.all(DEVICE_WIDTH * 0.03),
                    //     child: SvgPicture.asset(iconSearch),
                    //   ),
                    // ),
                    Expanded(
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: _model.onRefresh,
                            color: FlutterMadaTheme.of(context).primary,
                            backgroundColor: Colors.white,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _model.scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: DEVICE_WIDTH * 0.02,
                                      vertical: DEVICE_HEIGHT * 0.02,
                                    ),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                                        Text(
                                          FFLocalizations.of(context)
                                              .getText('quick_filter'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: _model
                                                  .onOrderByDistancePressed,
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                  DEVICE_WIDTH * 0.005,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: FlutterMadaTheme.of(
                                                            context)
                                                        .primary
                                                        .withOpacity(0.5),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    DEVICE_WIDTH * 0.1,
                                                  ),
                                                  color: _model.orderByDistance
                                                      ? FlutterMadaTheme.of(
                                                              context)
                                                          .primary
                                                          .withOpacity(0.15)
                                                      : Colors.white,
                                                ),
                                                child: SvgPicture.asset(
                                                  iconCurrentLocation,
                                                  colorFilter: ColorFilter.mode(
                                                    _model.orderByDistance
                                                        ? FlutterMadaTheme.of(
                                                                context)
                                                            .primary
                                                        : Colors.black,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: DEVICE_WIDTH * 0.01,
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: SelectList(
                                                  items: _model.filterProcess,
                                                  onTap: _model
                                                      .onFilterProcessPress,
                                                  textKey: keyName,
                                                  borderRadius:
                                                      DEVICE_WIDTH * 0.1,
                                                  borderWidth: 1,
                                                  borderColor: FlutterMadaTheme.of(context).color97BE5A,
                                                  selectedItem:
                                                      _model.selectedItems,
                                                  suffixWidget: _model
                                                          .selectedItems
                                                          .isNotEmpty
                                                      ? ResetFilter(
                                                          onResetFilter: _model
                                                              .resetFilters,
                                                          iconHeight:
                                                              DEVICE_HEIGHT *
                                                                  0.02,
                                                          horizontalPadding:
                                                              DEVICE_WIDTH *
                                                                  0.01,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                        )
                                                      : const Center(),
                                                  suffix: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: DEVICE_WIDTH *
                                                              0.015),
                                                      SizedBox(
                                                        child: SvgPicture.asset(
                                                          iconRoundedArrowDown,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: DEVICE_WIDTH * 0.02,
                                      vertical: DEVICE_HEIGHT * 0.02,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText('search_for_units'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${FFLocalizations.of(context).getText('result')}${_model.data[keyResults][keyFinalData][keyTotalDocs] ?? 0} ${FFLocalizations.of(context).getText('project')}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.02),
                                        Column(
                                          children: [
                                            if (_model.projectResult.isEmpty)
                                              SizedBox(
                                                height: DEVICE_HEIGHT * 0.1,
                                                child: const Center(),
                                              )
                                            else
                                              GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 0.8,
                                                  crossAxisSpacing:
                                                      DEVICE_WIDTH * 0.02,
                                                  mainAxisSpacing:
                                                      DEVICE_HEIGHT * 0.02,
                                                ),
                                                itemCount:
                                                    _model.projectResult.length,
                                                itemBuilder: (context, index) {
                                                  final property = _model
                                                      .projectResult[index];
                                                  return ProjectUnitCard(
                                                    item: property,
                                                    showContactIcons: true,
                                                    showComAndSub: true,
                                                    whatsAppMsg:
                                                        '${property[keyTitle] ?? ''}\n${property[keyPropertyCategory] ?? ''}\n${property[keyPrice] ?? 0} ${getCurrency()}\n${property[keyCommunity]} - ${property[keySubCommunity]}',
                                                    onFavoritesPressed: () {
                                                      _model
                                                          .favorites(property);
                                                    },
                                                    onTap: () {
                                                      _model.onPropertyPressed(
                                                        property[keyID],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // if (!_model.isLoading)
                          //   Positioned(
                          //     bottom: DEVICE_HEIGHT * 0.02,
                          //     left: DEVICE_WIDTH * 0.25,
                          //     right: DEVICE_WIDTH * 0.25,
                          //     child: CustomContainerButton(
                          //       text:
                          //           FFLocalizations.of(context).getText('sort'),
                          //       textStyle: Theme.of(context)
                          //           .textTheme
                          //           .bodySmall!
                          //           .copyWith(
                          //             color: Colors.white,
                          //           ),
                          //       backgroundColor:
                          //           FlutterMadaTheme.of(context).primary,
                          //       padding: EdgeInsets.symmetric(
                          //         vertical: DEVICE_HEIGHT * 0.019,
                          //         horizontal: DEVICE_WIDTH * 0.1,
                          //       ),
                          //       borderRadius: DEVICE_WIDTH * 0.08,
                          //       icon: iconSort,
                          //       onPressed: _model.onSortPressed,
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class AdsSection extends StatelessWidget {
  const AdsSection({
    required this.onAdPressed,
    super.key,
    this.showAdSection = false,
    this.image,
  });
  final bool showAdSection;
  final Function() onAdPressed;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showAdSection)
          Padding(
            padding: EdgeInsets.only(
              left: DEVICE_WIDTH * 0.05,
              right: DEVICE_WIDTH * 0.05,
              bottom: DEVICE_HEIGHT * 0.02,
            ),
            child: GestureDetector(
              onTap: onAdPressed,
              child: SizedBox(
                height: DEVICE_HEIGHT * 0.2,
                child: CachedImage(
                  borderRadius: DEVICE_HEIGHT * 0.01,
                  image: image,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
