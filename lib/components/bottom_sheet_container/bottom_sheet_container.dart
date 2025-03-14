import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../general_exports.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    this.child,
    this.title,
    this.subTitle,
    this.withCloseButton = true,
    Key? key,
    this.titlePadding,
    this.onClosingTheSheet,
    this.totalPadding,
    this.titleHorizontalPadding,
    this.titleVerticalPadding,
  }) : super(key: key);

  final Widget? child;
  final String? title;
  final String? subTitle;
  final double? titlePadding;
  final bool withCloseButton;
  final Function()? onClosingTheSheet;
  final EdgeInsetsGeometry? totalPadding;
  final double? titleHorizontalPadding;
  final double? titleVerticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: DEVICE_HEIGHT * 0.8,
      ),
      decoration: BoxDecoration(
        color:   FlutterMadaTheme.of(context).colorFFFFFF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DEVICE_WIDTH * 0.02),
          topRight: Radius.circular(DEVICE_WIDTH * 0.02),
        ),
      ),
      child: SingleChildScrollView(
        padding: totalPadding ?? EdgeInsets.all(DEVICE_WIDTH * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: titleHorizontalPadding ?? 0,
                vertical: titleVerticalPadding ?? 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null && title!.isNotEmpty)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: SizedBox(
                        width: DEVICE_WIDTH * 0.8,
                        child: Text(
                          title!,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  if (withCloseButton)
                    SizedBox(
                      width: DEVICE_WIDTH * 0.1,
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: GestureDetector(
                          onTap: onClosingTheSheet ?? (){
                            context.pop();
                          },
                          child: SvgPicture.asset(iconAix),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (subTitle != null && subTitle!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: DEVICE_WIDTH * 0.04),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    subTitle!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                  ),
                ),
              ),
            SizedBox(height: titlePadding ?? DEVICE_HEIGHT * 0.04),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
