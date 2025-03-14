import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

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

class Favorites extends StatelessWidget {
  const Favorites({super.key});

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
                      width: DEVICE_WIDTH * 0.01,
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
                                      borderColor: FlutterMadaTheme.of(context)
                                          .colorE1E1E1,
                                      onFavoritesPressed: () {
                                        controller.addOrRemoveFromFavorite(
                                            controller.units[index][keyID],
                                            PropertyType.unit,
                                            onRequestSuccess: () {
                                          controller.units.remove(
                                            controller.units[index],
                                          );
                                          // controller.update();
                                        });
                                      },
                                      onTap: () {
                                        // Get.toNamed(
                                        //   routeUnitDetails,
                                        //   arguments: {
                                        //     keyID: controller.units[index]
                                        //         [keyID],
                                        //   },
                                        // );
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 250,
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
                                      onTap: () {
                                        // Get.toNamed(
                                        //   routePropertyDetails,
                                        //   arguments: controller.units[index]
                                        //       [keyID],
                                        // );
                                      },
                                      onFavoritesPressed: () {
                                        controller.addOrRemoveFromFavorite(
                                          controller.units[index][keyID],
                                          PropertyType.property,
                                          onRequestSuccess: () {
                                            controller.units.remove(
                                              controller.units[index],
                                            );
                                            // controller.update();
                                          },
                                          bodyKey: 'propertyId',
                                        );
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 350,
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
