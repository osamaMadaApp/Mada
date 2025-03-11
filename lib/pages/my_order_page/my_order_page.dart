import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

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
      child: myOrderPageModel.units.isEmpty
          ? const Center()
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 50.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    FFLocalizations.of(context).getText('my_orders'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    FFLocalizations.of(context).getText('mada_properties'),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  ),
                  Column(
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
                                  text: 'exclusive_units'.tr,
                                  isSelected:
                                      myOrderPageModel.selectedCategory ==
                                          GeneralTaps.exclusiveUnits,
                                  onTap: () {
                                    myOrderPageModel.onChangeCategoryPress(
                                        GeneralTaps.exclusiveUnits);
                                  },
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                SelectableCategory(
                                  text: 'other_units'.tr,
                                  isSelected:
                                      myOrderPageModel.selectedCategory ==
                                          GeneralTaps.otherUnits,
                                  onTap: () {
                                    myOrderPageModel.onChangeCategoryPress(
                                        GeneralTaps.otherUnits);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: myOrderPageModel.onRefresh,
                          color: FlutterMadaTheme.of(context).primary,
                          backgroundColor: Colors.white,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: myOrderPageModel.scrollController,
                            child: Column(
                              children: <Widget>[
                                if (myOrderPageModel.selectedCategory ==
                                    GeneralTaps.exclusiveUnits)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: myOrderPageModel.units.length,
                                    padding: EdgeInsets.only(
                                      bottom: 5.h,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProjectUnitCard(
                                        item: myOrderPageModel.units[index],
                                        withFavorite: false,
                                        showOrderId: true,
                                        onTap: () {
                                          // Get.toNamed(
                                          //   routeUnitDetails,
                                          //   arguments: <String, dynamic>{
                                          //     keyID: myOrderPageModel.units[index]
                                          //         [keyUnitId],
                                          //   },
                                          // );
                                        },
                                      );
                                    },
                                  ),
                                if (myOrderPageModel.selectedCategory ==
                                    GeneralTaps.otherUnits)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: myOrderPageModel.units.length,
                                    padding: EdgeInsets.only(
                                      bottom: 5.h,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProjectUnitCard(
                                        item: myOrderPageModel.units[index],
                                        withFavorite: false,
                                        showContactIcons: true,
                                        showOrderId: true,
                                        onTap: () {
                                          // Get.toNamed(
                                          //   routePropertyDetails,
                                          //   arguments: myOrderPageModel.units[index]
                                          //       [keyPropertyId],
                                          // );
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
                ],
              ),
            ),
    );
  }
}
