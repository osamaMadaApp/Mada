import '../../general_exports.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesModel>(
      create: (BuildContext context) => FavoritesModel(),
      child: const Favorites(),
    );
  }
}

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (callBack) {
        Provider.of<FavoritesModel>(context, listen: false).getFavoriteList();
        Provider.of<FavoritesModel>(context, listen: false).addScrollListener();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesModel>(
      builder: (
        BuildContext context,
        FavoritesModel controller,
        Widget? child,
      ) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                FFLocalizations.of(context).getText('favorites'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                ),
                child: Row(
                  children: [
                    SelectableCategory(
                      text: FFLocalizations.of(context)
                          .getText('exclusive_units'),
                      isSelected: controller.selectedCategory ==
                          GeneralTaps.exclusiveUnits,
                      onTap: () {
                        controller.onChangeCategoryPress(
                          GeneralTaps.exclusiveUnits,
                        );
                      },
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SelectableCategory(
                      text: FFLocalizations.of(context).getText('other_units'),
                      isSelected:
                          controller.selectedCategory == GeneralTaps.otherUnits,
                      onTap: () {
                        controller.onChangeCategoryPress(
                          GeneralTaps.otherUnits,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.onRefresh,
                  color: FlutterMadaTheme.of(context).color8EC24D,
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        if (controller.isLoading)
                          const Center()
                        else
                          Column(
                            children: [
                              if (controller.selectedCategory ==
                                  GeneralTaps.exclusiveUnits)
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.units.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProjectUnitCard(
                                      item: controller.units[index],
                                      showContactIcons: true,
                                      borderColor: FlutterMadaTheme.of(context)
                                          .colorE1E1E1,
                                      verticalPadding: 0,
                                      onFavoritesPressed: () {
                                        controller.addOrRemoveFromFavorite(
                                          controller.units[index][keyID],
                                          PropertyType.unit,
                                          onRequestSuccess: () {
                                            controller.units.remove(
                                              controller.units[index],
                                            );
                                          },
                                        );
                                      },
                                      onTap: () {
                                        // Get.toNamed(
                                        //   routeUnitDetails,
                                        //   arguments: {
                                        //     keyID: controller.units[index]
                                        //         [keyID],
                                        //   },
                                        // );

                                        Navigator.pushNamed(
                                          context,
                                          Routes.routeUnitDetails,
                                          arguments: {
                                            keyID:
                                            controller.units[index][keyID],
                                          },
                                        );
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isPortrait(context) ? 2 : 3,
                                    mainAxisExtent:
                                        isPortrait(context) ? 280 : 250,
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 10.h,
                                  ),
                                ),
                              if (controller.selectedCategory ==
                                  GeneralTaps.otherUnits)
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.units.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProjectUnitCard(
                                      item: controller.units[index],
                                      showContactIcons: true,
                                      borderColor: FlutterMadaTheme.of(context)
                                          .colorE1E1E1,
                                      verticalPadding: 0,
                                      onFavoritesPressed: () {
                                        controller.addOrRemoveFromFavorite(
                                          controller.units[index][keyID],
                                          PropertyType.property,
                                          onRequestSuccess: () {
                                            controller.units.remove(
                                              controller.units[index],
                                            );
                                          },
                                          bodyKey: 'propertyId',
                                        );
                                      },
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.routePropertyDetails,
                                          arguments: {
                                            keyPropertyId:
                                                controller.units[index][keyID],
                                          },
                                        );
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isPortrait(context) ? 2 : 3,
                                    mainAxisExtent:
                                        isPortrait(context) ? 280 : 250,
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 10.h,
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
