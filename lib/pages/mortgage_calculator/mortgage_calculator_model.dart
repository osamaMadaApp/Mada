import 'package:intl/intl.dart';

import '../../app_state.dart';
import '../../general_exports.dart';

class MortgageCalculatorModel extends ChangeNotifier {
  MortgageCalculatorModel({required double propertyPrice}) {
    downPaymentFocusNode.addListener(() {
      downPaymentController.text = formatter.format(downPayment.toDouble());
    });
    percentageFocusNode.addListener(() {
      downPaymentController.text = formatter.format(downPayment.toDouble());
    });
    totalPrice = propertyPrice;
    onOpenMortgageCalculator();
    loanTermController.text = loanValue.toString();
    downPaymentController.text = getFormattedPrice(downPayment.toDouble());
  }

  int loanValue = 0;
  int downPayment = 0;
  double interestRate = 4.25;
  double monthlyPayment = 0;
  double totalPrice = 0;
  TextEditingController percentageController = TextEditingController();
  TextEditingController loanTermController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  FocusNode downPaymentFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  NumberFormat formatter = NumberFormat('###,###,###');
  Color loanThumbColor = Colors.black;
  Color downPaymentThumbColor = Colors.black;

  void onPriceChanged(double value) {
    totalPrice = value;
    onOpenMortgageCalculator();
    notifyListeners();
  }

  void onOpenMortgageCalculator() {
    onChangeLoanYears(FFAppState().masterDateJsonModel[keyLoanTenure] ?? 2);
    onChangeDownPayment(
      totalPrice *
          (FFAppState().masterDateJsonModel[keyMortgageDownPaymentPercentage] /
              100),
    );
  }

  void onChangeLoanYears(int value) {
    loanValue = value;
    loanTermController.text = loanValue.toInt().toString();
    if (loanValue >= 2) {
      updateMonthlyPayment();
    }
    notifyListeners();
  }

  void onChangeDownPayment(double value) {
    downPayment = value.toInt();
    downPaymentController.text = downPayment.toString();
    percentageController.text = getPercentage().round().toString();
    updateMonthlyPayment();
    notifyListeners();
  }

  void onChangeInterestRate(double value) {
    interestRate = value;
    updateMonthlyPayment();
    notifyListeners();
  }

  void onPercentageChanged(double value) {
    onChangeDownPayment(calculateDownPaymentPercentage(value));
    updateMonthlyPayment();
  }

  updateMonthlyPayment() {
    final double remainAmount = totalPrice - downPayment;
    final double interest = (remainAmount * interestRate) / 100;
    final double totalInterest = interest * loanValue;
    final double perMonth = (remainAmount + totalInterest) / (loanValue * 12);
    monthlyPayment = perMonth;
    notifyListeners();
  }

  double getPercentage() {
    return (downPayment / totalPrice) * 100;
  }

  double calculateDownPaymentPercentage(double percentage) {
    return (percentage / 100) * totalPrice;
  }

  bool getDownPaymentAvailability() {
    return int.parse(percentageController.text) >= 10 &&
        int.parse(percentageController.text) <= 80;
  }

  void viewUpfrontCosts(
    Function(dynamic result)? onSuccess,
  ) {
    if ((!getDownPaymentAvailability() || loanValue.toInt() < 2)) {
      return;
    }
    startLoading();
    ApiRequest(
      path: apiUpfrontCosts,
      method: ApiMethods.post,
      defaultHeadersValue: false,
      className: 'MortgageCalculatorController/viewUpfrontCosts',
      header: {
        keyLanguage: FFAppState().getSelectedLanguge(),
      },
      body: {
        'propertyPrice': totalPrice,
        'loanTerm': loanValue,
        'downPayment': downPayment,
        'downPaymentPercentage': getPercentage(),
        'interestRate': interestRate,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (data[keySuccess]) {
          onSuccess!(data[keyResults]);
        }
      },
    );
  }

  void update() {
    notifyListeners();
  }
}
