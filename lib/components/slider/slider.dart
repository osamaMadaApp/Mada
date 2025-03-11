import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../general_exports.dart';
import '../../index.dart';

class SliderComponent extends StatefulWidget {
  SliderComponent({
    required List<dynamic> items,
    this.sliderScreen = false,
    this.height,
    super.key,
    this.autoPlay = false,
    this.currentIndex,
    this.fit = BoxFit.fill,
    this.zoom = false,
    this.onImageTap,
    this.bottomGradient = false,
    this.isHome = false,
    this.logoWidth,
    this.logoHeight,
    this.enableImagePattern = false,
    this.enableBottomBlueLine = false,
    this.isOpenImageEnabled = false,
    this.topGradient = true,
    this.transverse = false,
    this.showIndicator = true,
    this.scrollPhysics,
    this.show360 = false,
    this.onThreeSixtyPressed,
    this.topLeftRadius = 6,
    this.topRightRadius = 6,
    this.bottomLeftRadius = 6,
    this.bottomRightRadius = 6,
  }) : _items = List.from(items);

  final List<dynamic> _items;
  final double? height;
  final bool sliderScreen;
  final bool? autoPlay;
  final int? currentIndex;
  final BoxFit fit;
  final bool zoom;
  final Function(dynamic item)? onImageTap;
  final bool bottomGradient;
  final bool isHome;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  final double? logoWidth;
  final double? logoHeight;
  final bool enableImagePattern;
  final bool enableBottomBlueLine;
  final bool topGradient;
  final bool transverse;
  final bool showIndicator;
  final bool isOpenImageEnabled;
  final ScrollPhysics? scrollPhysics;
  final bool show360;
  final Function()? onThreeSixtyPressed;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  @override
  _SliderComponentState createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.currentIndex ?? 0);
    if (widget._items.isEmpty) {
      widget._items.add(
        'https://cdn.bio.link/uploads/profile_pictures/2023-12-05/v9uFU8VrJx0siyCpEUfev2muZ0GJreBF.png',
      );
    }
  }

  void onPageUpdated(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const int slideDuration = 6;

    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            if (!widget.zoom)
              CarouselSlider.builder(
                itemCount: widget._items.length,
                options: CarouselOptions(
                  height: widget.height ?? 45.h,
                  autoPlay: widget.autoPlay ?? widget._items.length > 1,
                  initialPage: widget.currentIndex ?? 0,
                  autoPlayInterval: const Duration(
                    seconds: slideDuration,
                  ),
                  scrollPhysics: widget.scrollPhysics ??
                      const AlwaysScrollableScrollPhysics(),
                  viewportFraction: 1.0,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    onPageUpdated(index);
                  },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return GestureDetector(
                    onTap: widget.onImageTap != null
                        ? () => widget.onImageTap!.call(widget._items[index])
                        : null,
                    child: Stack(
                      children: <Widget>[
                        CachedImage(
                          image: widget._items[index] != null
                              ? widget._items[index] is String
                                  ? widget._items[index]
                                  : widget._items[index][keyImage]
                              : '',
                          width: double.infinity,
                          height: widget.height ?? 45.h,
                          fit: widget.fit,
                          withPlaceHolder: false,
                          transverse: widget.transverse,
                          topLeftBorder: widget.topLeftRadius,
                          topRightBorder: widget.topRightRadius,
                          bottomLeftBorder: widget.bottomLeftRadius,
                          bottomRightBorder: widget.bottomRightRadius,
                          enableImagePattern: widget.enableImagePattern,
                        ),

                        // Bottom Gradient
                        if (widget.bottomGradient)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(150, 0, 0, 0),
                                    Color.fromARGB(100, 0, 0, 0),
                                    Color.fromARGB(10, 0, 0, 0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(widget.bottomLeftRadius),
                                  bottomRight:
                                      Radius.circular(widget.bottomRightRadius),
                                ),
                              ),
                            ),
                          ),

                        // Top Gradient
                        if (widget.topGradient)
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(172, 0, 0, 0),
                                    Color.fromARGB(70, 0, 0, 0),
                                    Color.fromARGB(10, 0, 0, 0),
                                    Color.fromARGB(7, 0, 0, 0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(widget.topLeftRadius),
                                  topRight:
                                      Radius.circular(widget.topRightRadius),
                                ),
                              ),
                            ),
                          ),
                        if (widget.isOpenImageEnabled)
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.isOpenImageEnabled) {
                                  // Get.toNamed(
                                  //   routeSliderImageScreen,
                                  //   arguments: <String, dynamic>{
                                  //     keyPhotos: widget._items,
                                  //     keyIndex: index,
                                  //   },
                                  // );
                                }
                              },
                            ),
                          )
                      ],
                    ),
                  );
                },
                carouselController: widget.carouselController,
              )
            else
              SizedBox(
                height: widget.height ?? 0.45.h,
                child: PhotoViewGallery.builder(
                  itemCount: widget._items.length,
                  builder: (BuildContext context, int index) {
                    final item = widget._items[index];
                    return PhotoViewGalleryPageOptions(
                      imageProvider: item is String
                          ? Image.network(item).image
                          : Image.memory(item[keyImage]).image,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return ErrorImageWidget(
                          transverse: widget.transverse,
                        );
                      },
                      initialScale: PhotoViewComputedScale.contained,
                      heroAttributes: PhotoViewHeroAttributes(tag: index),
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  pageController: pageController,
                ),
              ),
            if (widget.show360)
              Positioned(
                bottom: 0.07.h,
                right: 0.35.h,
                left: 0.35.h,
                child: GestureDetector(
                  onTap: widget.onThreeSixtyPressed,
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: FlutterMadaTheme.of(context).colorFFFFFF,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 4.h,
                          ),
                          child: SizedBox(
                            height: 0.03.h,
                            width: 0.07.h,
                            child: Image.asset(imageThreeSixty),
                          ),
                        ),
                        SizedBox(
                          width: 0.02.h,
                        ),
                        Text(
                          '360_view'.tr,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: FlutterMadaTheme.of(context).primary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (widget.showIndicator && !widget.sliderScreen)
              Positioned(
                bottom: 30.h,
                right: isRTL ? 12.w : null,
                left: isRTL ? null : 12.w,
                child: SmoothIndicatorWidget(
                  itemCount: widget._items.length,
                  currentIndex: currentIndex,
                ),
              ),
          ],
        ),
        if (widget.sliderScreen)
          BackAndForwardIndicators(
            pageController: pageController,
          ),
      ],
    );
  }
}

class SmoothIndicatorWidget extends StatelessWidget {
  const SmoothIndicatorWidget({
    required this.itemCount,
    required this.currentIndex,
    super.key,
  });

  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: itemCount,
            effect: WormEffect(
              dotColor:
                  FlutterMadaTheme.of(context).colorFFFFFF.withOpacity(0.2),
              activeDotColor: FlutterMadaTheme.of(context).color97BE5A,
              offset: 12.h,
              dotHeight: 16.h,
              dotWidth: 16.h,
            ),
          ),
        ],
      ),
    );
  }
}

class BackAndForwardIndicators extends StatelessWidget {
  const BackAndForwardIndicators({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: FlutterMadaTheme.of(context).colorFFFFFF,
            ),
            onPressed: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 50),
                curve: Curves.bounceIn,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: FlutterMadaTheme.of(context).colorFFFFFF,
            ),
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 50),
                curve: Curves.bounceIn,
              );
            },
          ),
        ],
      ),
    );
  }
}
