import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({required this.item,this.onTap, super.key});

  final dynamic item;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: SliderComponent(
                      items: item[keyPhotos] ?? [] ?? <dynamic>[],
                      height: 220.h,
                      showIndicator: false,
                      fit: BoxFit.cover,
                      topGradient: false,
                      bottomLeftRadius: 0,
                      bottomRightRadius: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: item?[keyProjectType] != null,
                        child: LabelCard(
                            paddingVertical: 4.w,
                            paddingHorizontal: 8.w,
                            text: item?[keyProjectType] ?? ''),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
                        child: LabelCard(
                          paddingVertical: 4.w,
                          paddingHorizontal: 8.w,
                          text:
                              '${FFLocalizations.of(context).getText('available')} ${item[keyTotalAvailableUnits] ?? ''} ${FFLocalizations.of(context).getText('off')} ${item[keyTotalUnits] ?? ''}',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CachedImage(
                    image: item?[keyDeveloperImage] ?? testImage,
                    width: 41.w,
                    height: 41.w,
                    borderRadius: 4,
                    placeholder: imageGrayLogo,
                    showPlaceHolder: true,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item[keyTitle] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      FlutterMadaTheme.of(context).color000000,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: AppFonts.outfit,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB( 6.w, 0, 6.w, 0),
                                child: SvgPicture.asset(iconLocation),
                              ),
                              Expanded(
                                child: Text(
                                  item[keyCity]== null ? '${item[keySubCommunity] ?? ''}' : '${item[keyCity]} - ${item[keySubCommunity] ?? ''}',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: FlutterMadaTheme.of(context)
                                            .color989898,
                                        fontSize: 14,
                                        fontFamily: AppFonts.outfit,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse(
                          hexToColor(
                            item?[keyGetAvailableStatusLable]?[keyColorCode] ??
                                '#FFFFFF',
                          ),
                        ),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      item?[keyGetAvailableStatusLable]?[keyValue] ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: FlutterMadaTheme.of(context).colorFFFFFF,
                            fontSize: 12,
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
