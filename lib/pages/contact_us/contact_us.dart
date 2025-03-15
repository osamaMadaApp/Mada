// ignore_for_file: must_be_immutable

import 'dart:ui' as ui;

import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactUsModel(),
      child: const ContactUs(),
    );
  }
}

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 30.h,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                flex: 5,
                child: ContactUsSheets(),
              ),
              SizedBox(
                width: 20.w,
              ),
              const Expanded(
                flex: 3,
                child: ContactSheetButtons(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactUsSheets extends StatelessWidget {
  const ContactUsSheets({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: MediaQuery.of(context).size.height - 450.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  FFLocalizations.of(context).getText('contact_us'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Consumer<ContactUsModel>(
                  builder: (BuildContext context, ContactUsModel value,
                      Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                          ),
                          child: Row(
                            children: [
                              SelectableCategory(
                                text: FFLocalizations.of(context)
                                    .getText('individuals'),
                                isSelected:
                                    context.read<ContactUsModel>().selected ==
                                        ContactUsTypes.individuals,
                                onTap: () {
                                  context
                                      .read<ContactUsModel>()
                                      .onChangeSelectedType(
                                        ContactUsTypes.individuals,
                                      );
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SelectableCategory(
                                text: FFLocalizations.of(context)
                                    .getText('companies'),
                                isSelected:
                                    context.read<ContactUsModel>().selected ==
                                        ContactUsTypes.companies,
                                onTap: () {
                                  context
                                      .read<ContactUsModel>()
                                      .onChangeSelectedType(
                                        ContactUsTypes.companies,
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              if (context.read<ContactUsModel>().selected ==
                                  ContactUsTypes.individuals)
                                IndividualsSheet(
                                  onSendPress: context
                                      .read<ContactUsModel>()
                                      .onIndividualSendPress,
                                ),
                              if (context.read<ContactUsModel>().selected ==
                                  ContactUsTypes.companies)
                                CompanySheet(
                                  onSendPress: context
                                      .read<ContactUsModel>()
                                      .onCompanySendPress,
                                )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IndividualsSheet extends StatelessWidget {
  IndividualsSheet({
    required this.onSendPress,
    super.key,
  });

  final Function(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? msgTitle,
    String? typeMsg,
  )? onSendPress;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactUsModel>(
      builder: (BuildContext context, ContactUsModel model, Widget? child) {
        return Form(
          key: _formKey,
          child: Column(
            spacing: 20.h,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: model.firstNameController,
                      hint: FFLocalizations.of(context).getText('first_name'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: model.lastNameController,
                      hint: FFLocalizations.of(context).getText('last_name'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: model.emailController,
                      hint:
                          FFLocalizations.of(context).getText('email_address'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                favorite: <String>[
                                  'SA',
                                  'AE',
                                  'EG',
                                  'QA',
                                  'BH',
                                  'OM',
                                  'KW'
                                ],
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  model.updatePhoneCode(
                                    country.phoneCode,
                                    country.countryCode,
                                  );
                                },
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight:
                                      MediaQuery.of(context).size.height * 0.95,
                                  bottomSheetWidth:
                                      MediaQuery.of(context).size.width * 0.95,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 52.h,
                              width: 52.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: FlutterMadaTheme.of(context)
                                        .colorF4F4F4,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                child: CountryFlag.fromCountryCode(
                                  model.countryCode,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: CustomInput(
                              controller: model.phoneNumberController,
                              hint: model.countryCode == 'SA'
                                  ? '5XX XXX XXX'
                                  : 'XXX XXX XXX',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(
                                  model.countryCode == 'SA' ? 9 : 16,
                                ),
                              ],
                              validator: (value) {
                                if ((value == null ||
                                    !RegExp('^5').hasMatch(value) &&
                                        model.countryCode == 'SA')) {
                                  return FFLocalizations.of(context)
                                      .getText('please_enter_valid_number');
                                }
                                return null;
                              },
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: FlutterMadaTheme.of(context)
                                        .color989898,
                                  ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: model.msgTitleController,
                      hint: FFLocalizations.of(context).getText('msg_title'),
                    ),
                  ),
                ],
              ),
              CustomInput(
                controller: model.typeMessageController,
                hint: FFLocalizations.of(context).getText('type_msg'),
                maxLines: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CustomButton(
                      text: FFLocalizations.of(context).getText('send'),
                      borderRadius: 30.r,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onSendPress!(
                            model.firstNameController.text,
                            model.lastNameController.text,
                            model.emailController.text,
                            model.phoneNumberController.text,
                            model.msgTitleController.text,
                            model.typeMessageController.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CompanySheet extends StatelessWidget {
  CompanySheet({
    super.key,
    this.onSendPress,
  });

  final Function(
    String? companyname,
    String? empName,
    String? empPosition,
    String? email,
    String? phoneNumber,
    String? msgTitle,
    String? typeMsg,
  )? onSendPress;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactUsModel>(
      builder: (BuildContext context, model, Widget? child) {
        return Form(
          key: _formKey,
          child: Column(
            spacing: 20.h,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: model.companyNameController,
                      hint: FFLocalizations.of(context).getText('company_name'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: model.employeeNameController,
                      hint:
                          FFLocalizations.of(context).getText('employee_name'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: model.employeePositionController,
                      hint: FFLocalizations.of(context)
                          .getText('employee_position'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: model.CompanyEmailController,
                      hint:
                          FFLocalizations.of(context).getText('email_address'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                favorite: <String>[
                                  'SA',
                                  'AE',
                                  'EG',
                                  'QA',
                                  'BH',
                                  'OM',
                                  'KW'
                                ],
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  model.updatePhoneCode(
                                    country.phoneCode,
                                    country.countryCode,
                                    company: true,
                                  );
                                },
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight:
                                      MediaQuery.of(context).size.height * 0.95,
                                  bottomSheetWidth:
                                      MediaQuery.of(context).size.width * 0.95,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 52.h,
                              width: 52.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      FlutterMadaTheme.of(context).colorE1E1E1,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: FlutterMadaTheme.of(context)
                                        .colorF4F4F4,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                child: CountryFlag.fromCountryCode(
                                  model.companyCountryCode,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomInput(
                              controller: model.CompanyPhoneNumberController,
                              hint: model.companyCountryCode == 'SA'
                                  ? '5XX XXX XXX'
                                  : 'XXX XXX XXX',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(
                                  model.companyCountryCode == 'SA' ? 9 : 16,
                                ),
                              ],
                              validator: (value) {
                                if ((value == null ||
                                    !RegExp('^5').hasMatch(value) &&
                                        model.companyCountryCode == 'SA')) {
                                  return FFLocalizations.of(context)
                                      .getText('please_enter_valid_number');
                                }
                                return null;
                              },
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: FlutterMadaTheme.of(context)
                                        .color989898,
                                  ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: model.CompanyMsgTitleController,
                      hint: FFLocalizations.of(context).getText('msg_title'),
                    ),
                  ),
                ],
              ),
              CustomInput(
                controller: model.companyTypeMessageController,
                hint: FFLocalizations.of(context).getText('type_msg'),
                maxLines: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CustomButton(
                      text: FFLocalizations.of(context).getText('send'),
                      borderRadius: 30.r,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onSendPress!(
                            model.companyNameController.text,
                            model.employeeNameController.text,
                            model.employeePositionController.text,
                            model.CompanyEmailController.text,
                            model.CompanyPhoneNumberController.text,
                            model.CompanyMsgTitleController.text,
                            model.companyTypeMessageController.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ContactSheetButtons extends StatelessWidget {
  const ContactSheetButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      width: 300.w,
      height: MediaQuery.of(context).size.height - 450.h,
      decoration: BoxDecoration(
        color: FlutterMadaTheme.of(context).colorFFFFFF,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          Text(
            FFLocalizations.of(context).getText('contact_info'),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: 40.h,
          ),
          ContactUsMenuCard(
            text: FFLocalizations.of(context).getText('whatsapp'),
            value: FFAppState().masterDateJsonModel[keyAdminInfo][0][keyMobile],
            icon: iconWhatsapp,
            containerHeight: 70.h,
            onTap: () {
              whatsapp(
                FFAppState().masterDateJsonModel[keyAdminInfo][0][keyMobile],
                context,
                showWhatsMsg: true,
                isPaymentMsg: true,
              );
            },
          ),
          SizedBox(
            height: 30.h,
          ),
          ContactUsMenuCard(
            text: FFLocalizations.of(context).getText('phone'),
            icon: iconPhoneLogo,
            containerHeight: 70.h,
            onTap: () {
              makePhoneCall(
                FFAppState().masterDateJsonModel[keyAdminInfo][0][keyMobile],
              );
            },
            value: FFAppState().masterDateJsonModel[keyAdminInfo][0][keyMobile],
          ),
          SizedBox(
            height: 30.h,
          ),
          ContactUsMenuCard(
            text: FFLocalizations.of(context).getText('email'),
            value: FFAppState().masterDateJsonModel[keyAdminInfo][0][keyEmail],
            icon: iconEmailContact,
            containerHeight: 70.h,
            withLine: false,
            onTap: () {
              sendEmail(
                FFAppState().masterDateJsonModel[keyAdminInfo][0][keyEmail],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ContactUsMenuCard extends StatelessWidget {
  const ContactUsMenuCard({
    required this.text,
    required this.icon,
    required this.value,
    super.key,
    this.onTap,
    this.containerHeight,
    this.withLine = true,
  });

  final Function()? onTap;
  final String text;
  final String icon;
  final String value;
  final double? containerHeight;
  final bool withLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Center(
            child: Container(
              height: containerHeight ?? 7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: FlutterMadaTheme.of(context).colorFFFFFF,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    icon,
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MadaText(
                        text,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MadaText(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (withLine)
          Container(
            width: MediaQuery.of(context).size.width,
            height: 2.h,
            color: FlutterMadaTheme.of(context).colorF5F5F5,
          )
      ],
    );
  }
}
