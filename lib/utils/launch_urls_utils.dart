import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../general_exports.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final String url = 'tel:$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> sendEmail(String sendTo) async {
  consoleLog(sendTo);

  final Email email = Email(
    recipients: <String>[sendTo],
  );
  try {
    await FlutterEmailSender.send(email);
  } catch (e) {
    await launchUrl(Uri.parse('mailto:$sendTo?subject=&body='));
  }
}

Future<void> whatsapp(
  String phone, {
  String msg = '',
  bool showWhatsMsg = false,
  bool isPaymentMsg = false,
}) async {
  // MyAppController myAppController = Get.find<MyAppController>();
  const String fullWhatAppMsg = '';
  if (showWhatsMsg) {
    // String whatAppMsg = isPaymentMsg
    //     ? myAppController.masterData[keyWhatsAppMessageInfo] ?? ''
    //     : myAppController.masterData[keyWhatsAppShareText] ?? '';
    // fullWhatAppMsg = '$whatAppMsg\n$msg';
  }

  consoleLog(fullWhatAppMsg, key: 'full-whatsapp-msg');

  final String androidUrl = 'whatsapp://send?phone=$phone&text=$fullWhatAppMsg';
  final String iosUrl =
      'https://wa.me/$phone?text=${Uri.encodeComponent(fullWhatAppMsg)}';

  try {
    if (Platform.isIOS) {
      await launchUrl(
        Uri.parse(iosUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      await launchUrl(
        Uri.parse(androidUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  } on Exception {
    Fluttertoast.showToast(
      msg: 'whatsapp_not_installed'.tr,
    );
  }
}

Future<void> launchMaps(double? lat, double? long) async {
  if (lat != null && long != null) {
    final String url = Platform.isAndroid
        ? 'https://www.google.com/maps/search/?api=1&query=$lat,$long'
        : 'https://maps.apple.com/?q=$lat,$long';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error launching map');
    }
  } else {
    Fluttertoast.showToast(msg: 'error_maps'.tr);
  }
}
