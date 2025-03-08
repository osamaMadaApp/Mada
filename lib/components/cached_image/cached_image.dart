import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    required this.image,
    this.topLeftBorder = 0,
    this.topRightBorder = 0,
    this.bottomLeftBorder = 0,
    this.bottomRightBorder = 0,
    this.borderRadius,
    this.height,
    this.width,
    this.withPlaceHolder = true,
    this.fit = BoxFit.fill,
    Key? key,
    this.onTap,
    this.transverse = false,
    this.enableImagePattern = false,
    this.placeholder,
    this.showPlaceHolder = false,
  }) : super(key: key);

  final String? image;
  final double? height;
  final double? width;
  final double? topLeftBorder;
  final double? topRightBorder;
  final double? bottomLeftBorder;
  final double? bottomRightBorder;
  final double? borderRadius;
  final bool withPlaceHolder;
  final BoxFit fit;
  final Function()? onTap;
  final bool transverse;
  final bool enableImagePattern;
  final String? placeholder;
  final bool showPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return enableImagePattern
        ? Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius ?? topLeftBorder!),
                  topRight: Radius.circular(borderRadius ?? topRightBorder!),
                  bottomLeft:
                      Radius.circular(borderRadius ?? bottomLeftBorder!),
                  bottomRight:
                      Radius.circular(borderRadius ?? bottomRightBorder!),
                ),
                child: image != null && image!.isNotEmpty
                    ? image!.contains('svg')
                        ? SvgPicture.network(
                            image!,
                            fit: BoxFit.cover,
                            height: height,
                            width: width,
                          )
                        : CachedNetworkImage(
                            cacheKey: 'unique_cache_key_for_$image',
                            placeholder: (BuildContext context, String url) {
                              return ErrorImageWidget(
                                topLeftBorder: topLeftBorder,
                                topRightBorder: topRightBorder,
                                height: height,
                                width: width,
                                bottomLeftBorder: bottomLeftBorder,
                                bottomRightBorder: bottomRightBorder,
                                withPlaceHolder: withPlaceHolder,
                                fit: fit,
                                transverse: transverse,
                              );
                            },
                            errorWidget: (BuildContext context, String url,
                                Object error) {
                              return ErrorImageWidget(
                                key: UniqueKey(),
                                topLeftBorder: topLeftBorder,
                                topRightBorder: topRightBorder,
                                height: height,
                                width: width,
                                borderRadius: borderRadius,
                                bottomLeftBorder: bottomLeftBorder,
                                bottomRightBorder: bottomRightBorder,
                                withPlaceHolder: withPlaceHolder,
                                fit: fit,
                                transverse: transverse,
                              );
                            },
                            imageUrl: image!,
                            fit: fit,
                            height: height,
                            width: width,
                          )
                    : ErrorImageWidget(
                        topLeftBorder: topLeftBorder,
                        topRightBorder: topRightBorder,
                        height: height,
                        width: width,
                        borderRadius: borderRadius,
                        bottomLeftBorder: bottomLeftBorder,
                        bottomRightBorder: bottomRightBorder,
                        withPlaceHolder: withPlaceHolder,
                        fit: fit,
                        transverse: transverse,
                      ),
              ),
            ],
          )
        : ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius ?? topLeftBorder!),
              topRight: Radius.circular(borderRadius ?? topRightBorder!),
              bottomLeft: Radius.circular(borderRadius ?? bottomLeftBorder!),
              bottomRight: Radius.circular(borderRadius ?? bottomRightBorder!),
            ),
            child: image != null && image!.isNotEmpty
                ? image!.contains('svg')
                    ? SvgPicture.network(
                        image!,
                        fit: BoxFit.cover,
                        height: height,
                        width: width,
                      )
                    : CachedNetworkImage(
                        cacheKey: 'unique_cache_key_for_$image',
                        placeholder: (BuildContext context, String url) {
                          return ErrorImageWidget(
                            topLeftBorder: topLeftBorder,
                            topRightBorder: topRightBorder,
                            height: height,
                            width: width,
                            bottomLeftBorder: bottomLeftBorder,
                            bottomRightBorder: bottomRightBorder,
                            withPlaceHolder: withPlaceHolder,
                            fit: fit,
                            transverse: transverse,
                          );
                        },
                        errorWidget:
                            (BuildContext context, String url, Object error) {
                          return ErrorImageWidget(
                            key: UniqueKey(),
                            topLeftBorder: topLeftBorder,
                            topRightBorder: topRightBorder,
                            height: height,
                            width: width,
                            borderRadius: borderRadius,
                            bottomLeftBorder: bottomLeftBorder,
                            bottomRightBorder: bottomRightBorder,
                            withPlaceHolder: withPlaceHolder,
                            fit: fit,
                            placeHolder: placeholder,
                            showPlaceHolder: showPlaceHolder,
                            transverse: transverse,
                          );
                        },
                        imageUrl: image!,
                        fit: fit,
                        height: height,
                        width: width,
                      )
                : ErrorImageWidget(
                    topLeftBorder: topLeftBorder,
                    topRightBorder: topRightBorder,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                    bottomLeftBorder: bottomLeftBorder,
                    bottomRightBorder: bottomRightBorder,
                    withPlaceHolder: withPlaceHolder,
                    fit: fit,
                    transverse: transverse,
                  ),
          );
  }
}

class ErrorImageWidget extends StatelessWidget {
  const ErrorImageWidget({
    required this.transverse,
    this.topLeftBorder = 0,
    this.topRightBorder = 0,
    this.bottomLeftBorder = 0,
    this.bottomRightBorder = 0,
    this.borderRadius,
    this.height,
    this.width,
    this.withPlaceHolder = false,
    this.fit = BoxFit.fill,
    Key? key,
    this.placeHolder,
    this.showPlaceHolder = false,
  }) : super(key: key);

  final double? height;
  final double? width;
  final double? topLeftBorder;
  final double? topRightBorder;
  final double? bottomLeftBorder;
  final double? bottomRightBorder;
  final double? borderRadius;
  final bool withPlaceHolder;
  final BoxFit fit;
  final bool transverse;
  final String? placeHolder;
  final bool showPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: (showPlaceHolder && placeHolder != null)
          ? Image.asset(placeHolder!)
          : Center(),
    );
  }
}
