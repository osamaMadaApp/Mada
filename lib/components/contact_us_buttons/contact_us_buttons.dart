import '../../general_exports.dart';

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
              text: 'whatsApp'.tr,
              icon: iconWhatsapp,
              containerHeight: containerHeight,
              onTap: () {
                whatsapp(
                  '',
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
            text: 'phone'.tr,
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
            text: 'email'.tr,
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
            borderRadius: BorderRadius.circular(1.h),
            color: FlutterMadaTheme.of(context).gray600,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 1.w,
              ),
              SvgPicture.asset(
                icon,
                height: 2.h,
              ),
              SizedBox(
                width: 02.w,
              ),
              SizedBox(
                width: 2.w,
                child: MadaText(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
