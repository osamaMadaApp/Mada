import 'package:country_flags/country_flags.dart';

import '../../general_exports.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<MyOrderPageModel>(
          create: (BuildContext context) => MyOrderPageModel(),
        ),
      ],
      child: const MyOrders(),
    );
  }
}

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final MyOrderPageModel myOrderPageModel =
        Provider.of<MyOrderPageModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: myOrderPageModel.units == null
          ? const Center()
          : myOrderPageModel.units!.isEmpty && !myOrderPageModel.isLoading
              ? Center(
                  child: Text(
                    FFLocalizations.of(context).getText('no_data_found'),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                FFLocalizations.of(context)
                                    .getText('my_orders'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 18,
                                      color: FlutterMadaTheme.of(context)
                                          .color292D32,
                                      fontFamily: AppFonts.workSans,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                FFLocalizations.of(context)
                                    .getText('mada_properties'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontFamily: AppFonts.workSans,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            // onTap: onCountryChange,
                            child: Container(
                              height: 50.w,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: FlutterMadaTheme.of(context).colorE6EEF3,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 26.h,
                                horizontal: 10.w,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: CountryFlag.fromCountryCode(
                                  'sa',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: 1.h,
                                right: 1.h,
                                top: 2.h,
                                bottom: 1.h,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SelectableCategory(
                                        text: FFLocalizations.of(context)
                                            .getText('exclusive_units'),
                                        isSelected:
                                            myOrderPageModel.selectedCategory ==
                                                GeneralTaps.exclusiveUnits,
                                        onTap: () {
                                          myOrderPageModel
                                              .onChangeCategoryPress(
                                                  GeneralTaps.exclusiveUnits);
                                        },
                                      ),
                                      SizedBox(width: 8.w),
                                      SelectableCategory(
                                        text: FFLocalizations.of(context)
                                            .getText('other_units'),
                                        isSelected:
                                            myOrderPageModel.selectedCategory ==
                                                GeneralTaps.otherUnits,
                                        onTap: () {
                                          myOrderPageModel
                                              .onChangeCategoryPress(
                                                  GeneralTaps.otherUnits);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: myOrderPageModel.onRefresh,
                                color: FlutterMadaTheme.of(context).primary,
                                backgroundColor: Colors.white,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: myOrderPageModel.scrollController,
                                  child: Column(
                                    children: <Widget>[
                                      if (myOrderPageModel.selectedCategory ==
                                          GeneralTaps.exclusiveUnits)
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              myOrderPageModel.units!.length,
                                          padding: EdgeInsets.only(
                                            bottom: 5.h,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ProjectUnitCard(
                                              item: myOrderPageModel
                                                  .units![index],
                                              withFavorite: false,
                                              showOrderId: true,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.routeUnitDetails,
                                                  arguments: {
                                                    keyID: myOrderPageModel
                                                            .units?[index]
                                                        [keyUnitId],
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                isPortrait(context) ? 2 : 3,
                                            mainAxisExtent:
                                                isPortrait(context) ? 280 : 250,
                                          ),
                                        ),
                                      if (myOrderPageModel.selectedCategory ==
                                          GeneralTaps.otherUnits)
                                        GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                isPortrait(context) ? 2 : 3,
                                            mainAxisExtent:
                                                isPortrait(context) ? 320 : 350,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              myOrderPageModel.units!.length,
                                          padding: EdgeInsets.only(
                                            bottom: 5.h,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ProjectUnitCard(
                                              item: myOrderPageModel
                                                  .units![index],
                                              withFavorite: false,
                                              showContactIcons: true,
                                              showOrderId: true,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.routeUnitDetails,
                                                  arguments: {
                                                    keyPropertyId:
                                                        myOrderPageModel
                                                                .units?[index]
                                                            [keyPropertyId],
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
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
}
