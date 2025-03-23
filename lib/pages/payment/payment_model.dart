import '../../general_exports.dart';

class PaymentModel extends ChangeNotifier {
  dynamic data;
  bool isLoading = true;
  List<dynamic> paymentOptions = [];
  String? whatsAppDetails;
  dynamic params;
  dynamic selectedPaymentOption;
  List paymentMethods = [];

  // Customer details
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? customerName;
  String? mobileNumber;
  String? nationalId;
  String? emailAddress;
  String? address;

  void getPaymentOptionsDetails() {
    startLoading();
    ApiRequest(
      path: params[keyPropertyId] != null ? apiOwnProperty : apiOwnUnit,
      formatResponse: true,
      className: 'PaymentController/getPaymentOptionsDetails',
      queryParameters: params,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (data[keySuccess] == true) {
          this.data = data[keyResults];
          paymentOptions = this.data[keyPaymentOption] ?? [];
          isLoading = false;
          notifyListeners();
          if (params[keyPropertyId] != null) {
            whatsAppDetails =
                '${this.data[keyProperty][keyTitle] ?? ''}\n${this.data[keyProperty][keyPropertyCategory] ?? ''}\n${this.data[keyProperty][keyPrice] ?? 0} ${getCurrency()}\n${this.data[keyProperty][keyCity]} - ${this.data[keyProperty][keyCommunity]}';
          } else {
            whatsAppDetails =
                '${this.data[keyUnit][keyTitle] ?? ''}\n${this.data[keyUnit][keyPrice] ?? 0} ${getCurrency()}\n${this.data[keyUnit][keyCity]} - ${this.data[keyUnit][keyCommunity]}';
          }
        }

        notifyListeners();
      },
    );
  }

  void setParams(dynamic params) {
    this.params = params;
  }

  void selectPaymentOption(dynamic paymentOption) {
    if (selectedPaymentOption == paymentOption) {
      selectedPaymentOption = null;
    } else {
      selectedPaymentOption = paymentOption;
    }

    notifyListeners();
  }

  void setPaymentMethods(dynamic methods) {
    paymentMethods = List.from(methods);
    notifyListeners();
  }

  void initiatePayment(
    dynamic item,
    String selectPaymentMethodMsg, {
    Function(String url, bool isBuy)? onSuccess,
  }) {
    if (selectedPaymentOption == null) {
      showToast(selectPaymentMethodMsg);
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }

    final Map<String, dynamic> body = {};
    if (data[keyUnit] != null) {
      body[keyUnitId] = data[keyUnit][keyID];
    } else {
      body[keyPropertyId] = data[keyProperty][keyID];
    }
    body[keyPaymentMethods] = item['key'];

    startLoading();
    ApiRequest(
      path: apiInitiatePayment,
      method: ApiMethods.post,
      formatResponse: true,
      defaultHeadersValue: false,
      className: 'PaymentController/getPaymentOptionsDetails',
      body: body,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (data[keySuccess] == true) {
          if (data[keyResults][keyData][keyPaymentUrl] != null) {
            onSuccess!(data[keyResults][keyData][keyPaymentUrl], true);
          }
        }
        notifyListeners();
      },
    );
  }
}
