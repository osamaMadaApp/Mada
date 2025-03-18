import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../general_exports.dart';

class MortgageCalculator extends StatelessWidget {
  const MortgageCalculator({
    super.key,
    this.propertyPrice,
  });

  final double? propertyPrice;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MortgageCalculatorModel>(
      create: (BuildContext context) => MortgageCalculatorModel(
        propertyPrice: propertyPrice!,
      ),
      child: Consumer<MortgageCalculatorModel>(
        builder: (
          BuildContext context,
          MortgageCalculatorModel controller,
          Widget? child,
        ) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText('property_price'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(
                                AppColors.gray2,
                              ),
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      CustomInput(
                        initialValue: NumberFormat.decimalPattern()
                            .format(propertyPrice!.toInt()),
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            final String formattedValue =
                                value.replaceAll(',', '');
                            controller
                                .onPriceChanged(double.parse(formattedValue));
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ThousandsSeparatorInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getCurrency(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(AppColors.gray2),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.04),

                      // Loan Term Section
                      Text(
                        FFLocalizations.of(context).getText('loan_term'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color(AppColors.black),
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      Stack(
                        children: [
                          SizedBox(
                            height: DEVICE_HEIGHT * 0.07,
                            child: CustomInput(
                              controller: controller.loanTermController,
                              keyboardType: TextInputType.number,
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  controller
                                      .onChangeLoanYears(int.parse(value));
                                }
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly,
                                NumberRangeFormatter(min: 1, max: 25),
                              ],
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    FFLocalizations.of(context)
                                        .getText('years'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(AppColors.gray2),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: SizedBox(
                              height: DEVICE_HEIGHT * 0.031,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: DEVICE_HEIGHT * 0.025,
                                ),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: controller.loanThumbColor,
                                    overlayColor:
                                        const Color(AppColors.primary),
                                    valueIndicatorTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: const Color(AppColors.white),
                                        ),
                                  ),
                                  child: Slider(
                                    value: controller.loanValue.toDouble(),
                                    min: 1,
                                    max: 25,
                                    divisions: 24,
                                    onChangeStart: (double value) {
                                      controller.loanThumbColor =
                                          const Color(AppColors.primary);
                                    },
                                    onChangeEnd: (double value) {
                                      controller.loanThumbColor = Colors.black;
                                      controller.update();
                                    },
                                    label:
                                        '${controller.loanValue.toInt()} Years',
                                    onChanged: (value) {
                                      controller
                                          .onChangeLoanYears(value.toInt());
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      if (controller.loanValue.toInt() < 2)
                        Text(
                          FFLocalizations.of(context)
                              .getText('loan_term_must_be_2_years'),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(
                                      AppColors.red,
                                    ),
                                  ),
                        ),
                      SizedBox(height: DEVICE_HEIGHT * 0.02),
                      Text(
                        FFLocalizations.of(context).getText('down_payment'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color(AppColors.black),
                            ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),

                      Stack(
                        children: [
                          SizedBox(
                            height: DEVICE_HEIGHT * 0.07,
                            child: CustomInput(
                              focusNode: controller.downPaymentFocusNode,
                              controller: controller.downPaymentController,
                              keyboardType: TextInputType.number,
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  controller
                                      .onChangeDownPayment(double.parse(value));
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                NumberRangeFormatter(
                                  min: 1,
                                  max: controller.totalPrice.toInt(),
                                ),
                              ],
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getCurrency(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(AppColors.gray2),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Down Payment Slider
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: SizedBox(
                              height: DEVICE_HEIGHT * 0.031,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: DEVICE_HEIGHT * 0.025,
                                ),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor:
                                        controller.downPaymentThumbColor,
                                    overlayColor:
                                        const Color(AppColors.primary),
                                    valueIndicatorTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: const Color(AppColors.white),
                                        ),
                                  ),
                                  child: Slider(
                                    value: controller.downPayment.toDouble(),
                                    max: controller.totalPrice,
                                    divisions: 1000,
                                    onChangeStart: (double value) {
                                      controller.downPaymentThumbColor =
                                          const Color(AppColors.primary);
                                    },
                                    onChangeEnd: (double value) {
                                      controller.downPaymentThumbColor =
                                          Colors.black;
                                      controller.update();
                                    },
                                    label:
                                        '${getFormattedPrice(controller.downPayment.toDouble())} ${getCurrency()}',
                                    onChanged: (value) {
                                      controller.onChangeDownPayment(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      if (!controller.getDownPaymentAvailability())
                        Text(
                          FFLocalizations.of(context)
                              .getText('down_payment_must_be_at_least'),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(
                                      AppColors.red,
                                    ),
                                  ),
                        ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.04,
                      ),
                      Text(
                        FFLocalizations.of(context).getText('percentage'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(
                                AppColors.gray2,
                              ),
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.01,
                      ),
                      CustomInput(
                        focusNode: controller.percentageFocusNode,
                        controller: controller.percentageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            controller.onPercentageChanged(double.parse(value));
                          }
                        },
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText('%'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(
                                      AppColors.gray2,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.02,
                      ),
                      Text(
                        FFLocalizations.of(context).getText('interest_rate'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(
                                AppColors.gray2,
                              ),
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.01,
                      ),
                      CustomInput(
                        initialValue: controller.interestRate.toString(),
                        onChange: (value) {
                          controller.onChangeInterestRate(double.parse(value));
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText('%'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(
                                      AppColors.gray2,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.04,
                      ),
                      Text(
                        FFLocalizations.of(context).getText('monthly_payment'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            NumberFormat('#,##0.00')
                                .format(controller.monthlyPayment),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32,
                                  color: (controller
                                              .getDownPaymentAvailability() &&
                                          controller.loanValue.toInt() >= 2)
                                      ? const Color(AppColors.primary)
                                      : const Color(AppColors.gray6),
                                ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: DEVICE_HEIGHT * 0.005,
                            ),
                            child: Text(
                              ' ${getCurrency()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24,
                                    color: (controller
                                                .getDownPaymentAvailability() &&
                                            controller.loanValue.toInt() >= 2)
                                        ? const Color(AppColors.primary)
                                        : const Color(AppColors.gray6),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: DEVICE_WIDTH,
                child: CustomButton(
                  text:
                      FFLocalizations.of(context).getText('view_upfront_costs'),
                  onPressed: () {
                    controller.viewUpfrontCosts(
                      (dynamic results) {
                        Navigator.pop(context);
                        SideSheet.show(
                          context,
                          child: UpfrontCosts(
                            results: results,
                          ),
                          title: FFLocalizations.of(context)
                              .getText('upfront_costs'),
                        );
                      },
                    );
                  },
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(
                          AppColors.white,
                        ),
                      ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(AppColors.green3),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(DEVICE_WIDTH * 0.08),
                        bottomRight: Radius.circular(DEVICE_WIDTH * 0.08),
                        topLeft: Radius.circular(DEVICE_WIDTH * 0.08),
                        bottomLeft: Radius.circular(DEVICE_WIDTH * 0.08),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NumberRangeFormatter extends TextInputFormatter {
  NumberRangeFormatter({required this.min, required this.max});
  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new input is empty, allow it (user is deleting input)
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Try to parse the new value as an integer
    final int? value = int.tryParse(newValue.text);

    // If the input is not a number or is outside the allowed range, reject it
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    // Otherwise, accept the new input
    return newValue;
  }
}

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any commas for parsing
    final String numericString = newValue.text.replaceAll(',', '');
    if (numericString.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Parse the number and format it
    final number = double.tryParse(numericString);
    final formattedValue = NumberFormat('#,##0').format(number);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat numberFormat = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText =
        newValue.text.replaceAll(',', ''); // Remove commas for parsing
    if (newText.isEmpty) {
      return newValue;
    }

    final number = int.tryParse(newText);
    if (number == null) {
      return oldValue; // Return the old value if parsing fails
    }

    // Format the number with thousands separators
    final formattedText = numberFormat.format(number);

    // Return the updated text with selection positioned correctly
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
