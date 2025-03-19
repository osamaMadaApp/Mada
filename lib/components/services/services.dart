import '../../general_exports.dart';

class Services extends StatelessWidget {
  const Services({
    required this.services,
    super.key,
    this.showLine = true,
    this.bottomPadding,
  });

  final List<dynamic> services;

  final bool showLine;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
      child: Column(
        spacing: 30.h,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MadaText(
                FFLocalizations.of(context).getText('services'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        AppColors.black,
                      ),
                    ),
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.1,
                    width: DEVICE_WIDTH * 0.55,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: ServiceCard(
                            icon: services[index][keyIcon],
                            name: services[index][keyName] ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (showLine) const GrayLine(),
        ],
      ),
    );
  }
}
