import '../../app_state.dart';
import '../../general_exports.dart';

class ContactUsButtons extends StatelessWidget {
  const ContactUsButtons({
    super.key,
    this.showEmail = false,
    this.email,
    this.phoneNumber,
    this.whatsappNumber,
    this.showWhatsApp = true,
    this.whatsappMsg,
    this.isPaymentMsg = false,
    this.showText = true,
  });

  final String? email;
  final String? phoneNumber;
  final String? whatsappNumber;
  final bool showEmail;
  final bool showWhatsApp;
  final String? whatsappMsg;
  final bool isPaymentMsg;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (showWhatsApp)
          Expanded(
            child: ContactUsCard(
              text: showText
                  ? FFLocalizations.of(context).getText('whatsapp')
                  : '',
              icon: iconWhatsapp,
              onTap: () {
                whatsapp(
                  '',
                  context,
                  msg: whatsappMsg ??
                      FFAppState().masterDateJsonModel[keyAdminInfo][0]
                          [keyMobile],
                  showWhatsMsg: true,
                  isPaymentMsg: isPaymentMsg,
                );
              },
            ),
          ),
        if (showWhatsApp)
          SizedBox(
            width: 2.w,
          ),
        Expanded(
          child: ContactUsCard(
            text: showText ? FFLocalizations.of(context).getText('phone') : '',
            icon: iconPhoneLogo,
            onTap: () {
              makePhoneCall(
                phoneNumber ??
                    FFAppState().masterDateJsonModel[keyAdminInfo][0]
                        [keyMobile],
              );
            },
          ),
        ),
        if (showEmail)
          SizedBox(
            width: 2.w,
          ),
        if (showEmail)
          Expanded(
            child: ContactUsCard(
              text:
                  showText ? FFLocalizations.of(context).getText('email') : '',
              icon: iconEmailContact,
              onTap: () {
                sendEmail(
                  email ??
                      FFAppState().masterDateJsonModel[keyAdminInfo][0]
                          [keyEmail],
                );
              },
            ),
          ),
      ],
    );
  }
}

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({
    required this.text,
    required this.icon,
    super.key,
    this.onTap,
  });

  final Function()? onTap;
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: FlutterMadaTheme.of(context).colorD2D2D240,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                icon,
              ),
              SizedBox(width: 8.w),
              MadaText(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
