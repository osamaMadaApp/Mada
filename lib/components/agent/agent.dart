import '../../general_exports.dart';

class Agent extends StatelessWidget {
  const Agent({super.key, this.agentInfo});
  final dynamic agentInfo;

  @override
  Widget build(BuildContext context) {
    return agentInfo[keyFirstName] != null && agentInfo[keyFirstName].isNotEmpty
        ? Column(
            children: [
              const GrayLine(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MadaText(
                    FFLocalizations.of(context).getText('agent'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            child: CachedImage(
                              image: agentInfo[keyProfilePIC] ?? testImage,
                              height: DEVICE_HEIGHT * 0.08,
                              width: DEVICE_WIDTH * 0.08,
                              placeholder: imageUser,
                              showPlaceHolder: true,
                            ),
                          ),
                          SizedBox(
                            width: DEVICE_WIDTH * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MadaText(
                                '${agentInfo[keyFirstName] ?? ''} ${agentInfo[keyLastName] ?? ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(
                                        AppColors.black,
                                      ),
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: isRTL ? 2 : 0,
                        child: SvgPicture.asset(iconArrowGrey),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const GrayLine(),
            ],
          )
        : const Center();
  }
}
