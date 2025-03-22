import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class PaymentPlans extends StatelessWidget {
  const PaymentPlans({
    required this.paymentPlans,
    required this.onPaymentPlanExpanded,
    super.key,
    this.showGrayLine = true,
    this.isPaymentPlanExpanded = false,
    this.percentageKey,
    this.showAmount = true,
    this.childAspectRatio,
  });

  final List<dynamic> paymentPlans;
  final bool showGrayLine;
  final bool isPaymentPlanExpanded;
  final String? percentageKey;
  final bool showAmount;
  final double? childAspectRatio;
  final Function onPaymentPlanExpanded;

  @override
  Widget build(BuildContext context) {
    return (paymentPlans.isNotEmpty)
        ? Column(
            children: [
              if (showGrayLine)
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: const GrayLine(),
                ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (paymentPlans.isNotEmpty)
                      Column(
                        children: [
                          MadaText(
                            FFLocalizations.of(context)
                                .getText('payment_plans'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(
                                    AppColors.black,
                                  ),
                                ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ListView.builder(
                      itemCount: paymentPlans.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= 3 && !isPaymentPlanExpanded)
                          return const Center();
                        return Column(
                          children: [
                            if (index == 0 && showAmount)
                              TextWithValue(
                                text: FFLocalizations.of(context)
                                    .getText('installments'),
                                value: FFLocalizations.of(context)
                                    .getText('amount'),
                                color: index % 2 == 1
                                    ? const Color(AppColors.white)
                                    : const Color(AppColors.primary)
                                        .withOpacity(0.1),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(
                                        AppColors.black,
                                      ),
                                    ),
                                middleValue: FFLocalizations.of(context)
                                    .getText('percentage'),
                              ),
                            if (index == 0 && !showAmount)
                              TextWithValue(
                                text: FFLocalizations.of(context)
                                    .getText('installments'),
                                value: FFLocalizations.of(context)
                                    .getText('percentage'),
                                color: index % 2 == 1
                                    ? const Color(AppColors.white)
                                    : const Color(AppColors.primary)
                                        .withOpacity(0.1),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(
                                        AppColors.black,
                                      ),
                                    ),
                              ),
                            if (showAmount)
                              TextWithValue(
                                text: paymentPlans[index][keyName] ?? '',
                                value:
                                    '${NumberFormat('#,##0.00').format(paymentPlans[index][keyAmount])} ${getCurrency()}',
                                color: index % 2 != 1
                                    ? const Color(AppColors.white)
                                    : const Color(AppColors.primary)
                                        .withOpacity(0.1),
                                middleValue: paymentPlans[index][keyPercent],
                              ),
                            if (!showAmount)
                              TextWithValue(
                                text: paymentPlans[index][keyName] ?? '',
                                value: paymentPlans[index][keyPercent] ?? '',
                                color: index % 2 != 1
                                    ? const Color(AppColors.white)
                                    : const Color(AppColors.primary)
                                        .withOpacity(0.1),
                              )
                          ],
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        onPaymentPlanExpanded.call();
                      },
                      child: Container(
                        padding: EdgeInsets.all(DEVICE_HEIGHT * 0.02),
                        decoration: BoxDecoration(
                          color: Color(
                            (isPaymentPlanExpanded &&
                                    paymentPlans.length.isEven)
                                ? AppColors.white
                                : AppColors.primary,
                          ).withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(DEVICE_HEIGHT * 0.01),
                        ),
                        child: Row(
                          children: [
                            MadaText(
                              FFLocalizations.of(context).getText(
                                isPaymentPlanExpanded ? 'see_less' : 'see_more',
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                            SizedBox(width: 4.w),
                            RotatedBox(
                              quarterTurns: isPaymentPlanExpanded ? 2 : 0,
                              child: SvgPicture.asset(
                                iconTwoArrowsDown,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        : const Center();
  }
}
