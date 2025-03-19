import '../../general_exports.dart';

class ContactUsDetails extends StatelessWidget {
  const ContactUsDetails({
    super.key,
    this.phoneNumber,
    this.whatsapp,
    this.showWhatsapp = true,
    this.whatsappMsg,
    this.paddingTop = 0.02,
  });
  final String? phoneNumber;
  final String? whatsapp;
  final bool showWhatsapp;
  final String? whatsappMsg;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: DEVICE_HEIGHT * paddingTop,
        bottom: DEVICE_HEIGHT * 0.01,
      ),
      child: Column(
        spacing: 5.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MadaText(
            FFLocalizations.of(context).getText('contact_us_for_more_details'),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(AppColors.black),
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.02,
          ),
          ContactUsButtons(
            phoneNumber: phoneNumber,
            whatsappNumber: whatsapp,
            showWhatsApp: showWhatsapp,
            whatsappMsg: whatsappMsg,
          ),
        ],
      ),
    );
  }
}
