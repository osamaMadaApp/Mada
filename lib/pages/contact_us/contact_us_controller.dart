import '../../general_exports.dart';

class ContactUsModel extends ChangeNotifier {
  ContactUsTypes selected = ContactUsTypes.individuals;

  // For individual
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController msgTitleController = TextEditingController();
  TextEditingController typeMessageController = TextEditingController();
  String phoneCode = '966';
  String countryCode = 'SA';

  // For company
  TextEditingController companyNameController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeePositionController = TextEditingController();
  TextEditingController CompanyEmailController = TextEditingController();
  TextEditingController CompanyPhoneNumberController = TextEditingController();
  TextEditingController CompanyMsgTitleController = TextEditingController();
  TextEditingController companyTypeMessageController = TextEditingController();
  String companyPhoneCode = '966';
  String companyCountryCode = 'SA';

  onChangeSelectedType(ContactUsTypes value) {
    selected = value;
    notifyListeners();
  }

  void onIndividualSendPress(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? msgTitle,
    String? typeMsg,
  ) {
    final Map<String, dynamic> body = {
      keyContactType: 'Individuals',
      keyFirstName: firstName,
      keyLastName: lastName,
      keyMessageTitle: msgTitle,
      keyMessage: typeMsg,
      keyEmail: email,
      keyMobile: phoneNumber,
      keyCountryCode: phoneCode,
    };

    send(body);
  }

  void onCompanySendPress(
    String? companyname,
    String? empName,
    String? empPosition,
    String? email,
    String? phoneNumber,
    String? msgTitle,
    String? typeMsg,
  ) {
    final Map<String, dynamic> body = {
      keyContactType: 'Comapnies',
      keyCompanyName: companyname,
      keyEmail: email,
      keyEmployeeName: empName,
      keyEmployeePosition: empPosition,
      keyCountryCode: companyPhoneCode,
      keyMobile: phoneNumber,
      keyMessageTitle: msgTitle,
      keyMessage: typeMsg,
    };

    send(body);
  }

  void send(dynamic body) {
    startLoading();
    ApiRequest(
      path: apiContactUs,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      className: 'ContactUsModel/send',
      body: body,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (response[keySuccess] == true) {
          // perform some action
          resetControllers();
        }
        showToast(response[keyMsg]);
      },
    );
  }

  void resetControllers() {
    // Reset Individual Fields
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    msgTitleController.clear();
    typeMessageController.clear();
    phoneCode = '966';
    countryCode = 'SA';

    // Reset Company Fields
    companyNameController.clear();
    employeeNameController.clear();
    employeePositionController.clear();
    CompanyEmailController.clear();
    CompanyPhoneNumberController.clear();
    CompanyMsgTitleController.clear();
    companyTypeMessageController.clear();
    companyPhoneCode = '966';
    companyCountryCode = 'SA';

    notifyListeners();
  }

  void updatePhoneCode(
    String phoneCode,
    String countryCode, {
    bool company = false,
  }) {
    if (company) {
      companyPhoneCode = phoneCode;
      companyCountryCode = countryCode;
    } else {
      this.phoneCode = phoneCode;
      this.countryCode = countryCode;
    }
    notifyListeners();
  }
}
