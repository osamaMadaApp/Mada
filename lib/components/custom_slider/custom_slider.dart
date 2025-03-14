import 'dart:async';

import '../../general_exports.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({required this.sliderList, super.key});
  final List<dynamic> sliderList;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 1;
  List<dynamic> loopingList = [];

  @override
  void initState() {
    super.initState();

    loopingList = [
      widget.sliderList.last,
      ...widget.sliderList,
      widget.sliderList.first,
    ];

    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: 0.33,
    );

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        setState(() {
          _currentIndex++;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sliderList.isEmpty) return const SizedBox();

    return SizedBox(
      height: 250.h,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(
            () {
              _currentIndex = index;

              if (index == 0) {
                _currentIndex = loopingList.length - 2;
                _pageController.jumpToPage(_currentIndex);
              } else if (index == loopingList.length - 1) {
                _currentIndex = 1;
                _pageController.jumpToPage(_currentIndex);
              }
            },
          );
        },
        itemCount: loopingList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: 400.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedImage(
                  image: loopingList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
