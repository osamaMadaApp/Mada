import '../../general_exports.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    this.images,
    this.projectImage,
    this.projectName = '',
    this.projectAddress = '',
    this.statusText = '',
    this.horizontalPadding,
    this.verticalPadding,
    this.onTap,
    this.projectStatus,
    this.availableUnits,
    this.totalUnits,
    this.scrollPhysics,
    this.width,
    this.maxLines,
    this.showLocationIcon = true,
    this.subtitleVerticalPadding,
    this.getAvailableStatusLable,
    this.projectCategory,
    this.forceShowProjectImage = false,
    this.showProjectCategory = false,
  });

  final List<dynamic>? images;
  final String? projectImage;
  final String projectName;
  final String projectAddress;
  final String statusText;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Function()? onTap;
  final String? projectStatus;
  final int? availableUnits;
  final int? totalUnits;
  final ScrollPhysics? scrollPhysics;
  final double? width;
  final int? maxLines;
  final bool showLocationIcon;
  final double? subtitleVerticalPadding;
  final dynamic getAvailableStatusLable;
  final String? projectCategory;
  final bool showProjectCategory;
  final bool forceShowProjectImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 8.w,
          horizontal: horizontalPadding ?? 6.w,
        ),
        width: width ?? 290.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: SliderComponent(
                      items: images ?? <dynamic>[],
                      height: 222.h,
                      showIndicator: false,
                      fit: BoxFit.cover,
                      topGradient: false,
                      bottomLeftRadius: 0,
                      bottomRightRadius: 0,
                      scrollPhysics: scrollPhysics,
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
                      if (projectStatus != null && projectStatus!.isNotEmpty)
                        LabelCard(text: projectStatus!)
                      else
                        const Center(),
                      if (showProjectCategory && projectCategory != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: LabelCard(text: projectCategory!),
                        )
                      else
                        const Center(),
                      SizedBox(width: 4.w),
                      if ((availableUnits != null && availableUnits != 0) &&
                          (totalUnits != null && totalUnits != 0))
                        LabelCard(
                          text:
                              '${FFLocalizations.of(context).getText('available')} $availableUnits ${FFLocalizations.of(context).getText('of')} $totalUnits',
                        )
                      else
                        const Center(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 8.w),
                  if (projectImage != null)
                    CachedImage(
                      image: projectImage,
                      borderRadius: 4.w,
                      width: 30.w,
                      height: 30.w,
                    ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          projectName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: FlutterMadaTheme.of(context).color000000,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                          maxLines: maxLines,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: <Widget>[
                            if (showLocationIcon)
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(iconLocation),
                                  SizedBox(width: 8.w),
                                ],
                              ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: subtitleVerticalPadding ?? 0,
                              ),
                              child: Text(
                                projectAddress,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: FlutterMadaTheme.of(context)
                                          .color989898,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (getAvailableStatusLable != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(
                            hexToColor(
                              getAvailableStatusLable[keyColorCode] ??
                                  '#FFFFFF',
                            ),
                          ),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        getAvailableStatusLable[keyValue],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
