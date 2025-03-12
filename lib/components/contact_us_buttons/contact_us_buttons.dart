import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class ContactUsButtons extends StatelessWidget {
  const ContactUsButtons({
    super.key,
    this.showEmail = false,
    this.email,
    this.phoneNumber,
    this.whatsappNumber,
    this.containerHeight,
    this.showWhatsApp = true,
    this.whatsappMsg,
    this.isPaymentMsg = false,
  });

  final String? email;
  final String? phoneNumber;
  final String? whatsappNumber;
  final bool showEmail;
  final double? containerHeight;
  final bool showWhatsApp;
  final String? whatsappMsg;
  final bool isPaymentMsg;

  @override
  Widget build(BuildContext context) {
    // final MyAppController myAppController = Get.find<MyAppController>();
    return Row(
      children: <Widget>[
        if (showWhatsApp)
          Expanded(
            child: ContactUsCard(
              text: FFLocalizations.of(context).getText('whatsapp'),
              icon: iconWhatsapp,
              containerHeight: containerHeight,
              onTap: () {
                whatsapp(
                  '',
                  context,
                  // whatsappNumber ??
                  //     myAppController.masterData[keyAdminInfo][0][keyMobile],
                  msg: whatsappMsg ?? '',
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
            text: FFLocalizations.of(context).getText('phone'),
            icon: iconPhoneLogo,
            containerHeight: containerHeight,
            onTap: () {
              // makePhoneCall(
              //   phoneNumber ??
              //       myAppController.masterData[keyAdminInfo][0][keyMobile],
              // );
            },
          ),
        ),
        if (showEmail)
          SizedBox(
            width: 2.w,
          ),
        if (showEmail)
          ContactUsCard(
            text: FFLocalizations.of(context).getText('email'),
            icon: iconEmailContact,
            containerHeight: containerHeight,
            onTap: () {
              sendEmail(
                email ?? '',
                // email ?? myAppController.masterData[keyAdminInfo][0][keyEmail],
              );
            },
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
    this.containerHeight,
  });

  final Function()? onTap;
  final String text;
  final String icon;
  final double? containerHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: containerHeight ?? 7.h,
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
