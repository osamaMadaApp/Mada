import '../../general_exports.dart';

class ProjectInformation extends StatelessWidget {
  const ProjectInformation({
    required this.projectInfo,
    super.key,
    this.title,
    this.titleStyle,
    this.padding,
    this.textKey = 'key',
    this.valueKey = keyValue,
  });
  final List<dynamic> projectInfo;
  final String? title;
  final TextStyle? titleStyle;
  final double? padding;
  final String textKey;
  final String valueKey;

  @override
  Widget build(BuildContext context) {
    return projectInfo.isNotEmpty
        ? Padding(
            padding: EdgeInsets.all(padding ?? DEVICE_HEIGHT * 0.02),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MadaText(
                      title ??
                          FFLocalizations.of(context).getText('project_info'),
                      style: titleStyle ??
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: const Color(
                                  AppColors.black,
                                ),
                              ),
                    ),
                    SizedBox(
                      height: DEVICE_HEIGHT * 0.02,
                    ),
                    ListView.builder(
                      itemCount: projectInfo.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return TextWithValue(
                          text: projectInfo[index][textKey] ?? '',
                          value: projectInfo[index][valueKey] == null
                              ? ''
                              : valueKey == keyAmount
                                  ? '${getFormattedPrice(projectInfo[index][valueKey].toDouble())} ${getCurrency()}'
                                  : projectInfo[index][valueKey].toString(),
                          color: index.isOdd
                              ? const Color(AppColors.white)
                              : const Color(AppColors.primary).withOpacity(0.1),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.02,
                ),
                const GrayLine(),
              ],
            ),
          )
        : const Center();
  }
}
