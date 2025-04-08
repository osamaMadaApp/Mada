import '../../app_state.dart';
import '../../general_exports.dart';

class ReportPropertySheet extends StatelessWidget {
  ReportPropertySheet({super.key, this.onSendReport});

  final Function(
    String reasonId,
    String userType,
    String otherDetails,
  )? onSendReport;

  final TextEditingController typeMessageController = TextEditingController();
  String reasonId = '';
  String userType = '';

  @override
  Widget build(BuildContext context) {
    final dynamic masterData = FFAppState().masterDateJsonModel;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              FFLocalizations.of(context).getText('report_reason'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.01,
            ),
            MadaDropdownList(
              label: FFLocalizations.of(context).getText('select_the_reason'),
              items: masterData[keyReportReason],
              textKey: keyName,
              valueKey: keyID,
              onChanged: (value) {
                reasonId = value;
              },
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.03,
            ),
            Text(
              FFLocalizations.of(context).getText('user_type'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.01,
            ),
            MadaDropdownList(
              label: FFLocalizations.of(context).getText('select_the_type'),
              items: masterData[keyUserTypeReason],
              onChanged: (value) {
                userType = value;
              },
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.03,
            ),
            Text(
              FFLocalizations.of(context).getText('other_comments'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.02,
            ),
            Text(
              FFLocalizations.of(context)
                  .getText('add_your_additional_comments'),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(AppColors.gray2),
                  ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.005,
            ),
            CustomInput(
              controller: typeMessageController,
              hint: FFLocalizations.of(context).getText('type_msg'),
              maxLines: 5,
            ),
          ],
        ),
        SizedBox(
          width: DEVICE_WIDTH,
          child: CustomButton(
            text: FFLocalizations.of(context).getText('send_report'),
            onPressed: () {
              onSendReport!(reasonId, userType, typeMessageController.text);
            },
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: const Color(
                    AppColors.white,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
