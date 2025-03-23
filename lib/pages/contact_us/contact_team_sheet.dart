import '../../general_exports.dart';

class ContactTeamSheet extends StatelessWidget {
  const ContactTeamSheet({
    super.key,
    this.whatsappMsg,
  });
  final String? whatsappMsg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  FFLocalizations.of(context)
                      .getText('online_booking_available'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(AppColors.black),
                      ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                ContactUsButtons(
                  whatsappMsg: whatsappMsg,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: DEVICE_WIDTH,
          child: CustomButton(
            text: FFLocalizations.of(context).getText('confirm'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
