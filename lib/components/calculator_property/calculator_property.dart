import '../../general_exports.dart';

class CalculatorProperty extends StatelessWidget {
  const CalculatorProperty({
    required this.propertyPrice,
    required this.monthlyPayment,
    super.key,
    this.propertyAmountDetail,
    this.showLine = true,
    this.mortgageTitle,
    this.showTitle = false,
  });
  final dynamic propertyAmountDetail;
  final double propertyPrice;
  final bool showLine;
  final String? mortgageTitle;
  final bool showTitle;
  final double monthlyPayment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showTitle)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DEVICE_WIDTH * 0.04,
            ),
            child: Row(
              children: [
                MadaText(
                  mortgageTitle ??
                      FFLocalizations.of(context)
                          .getText('mortgage_calculator'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(AppColors.black),
                      ),
                ),
              ],
            ),
          ),
        if (propertyAmountDetail != null)
          Column(
            children: [
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
              MadaText(
                propertyAmountDetail[keyAmountTitle] ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        AppColors.black,
                      ),
                    ),
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MadaText(
                    getFormattedPrice(monthlyPayment.toDouble()),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: const Color(
                            AppColors.green2,
                          ),
                        ),
                  ),
                  SizedBox(
                    width: DEVICE_WIDTH * 0.01,
                  ),
                  MadaText(
                    '${getCurrency()} / ${FFLocalizations.of(context).getText('month')}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: const Color(
                            AppColors.green2,
                          ),
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.02,
              ),
              MadaText(
                propertyAmountDetail[keyAmountRate] ?? '',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(
                        AppColors.black,
                      ),
                    ),
              ),
            ],
          ),
        Padding(
          padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
          child: GestureDetector(
            onTap: () {
              SideSheet.show(
                context,
                child: MortgageCalculator(
                  propertyPrice: propertyPrice,
                ),
                title: FFLocalizations.of(context).getText(
                  'mortgage_calculator',
                ),
              );
            },
            child: Container(
              color: const Color(AppColors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(iconCalculator),
                      SizedBox(
                        width: DEVICE_WIDTH * 0.02,
                      ),
                      SizedBox(
                        width: DEVICE_WIDTH * 0.22,
                        child: MadaText(
                          FFLocalizations.of(context).getText(
                              'estimates_your_monthly_mortgage_payments'),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(
                                      AppColors.black,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                  RotatedBox(
                    quarterTurns: isRTL ? 2 : 0,
                    child: SvgPicture.asset(iconArrowGreen),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showLine) const GrayLine(),
      ],
    );
  }
}
