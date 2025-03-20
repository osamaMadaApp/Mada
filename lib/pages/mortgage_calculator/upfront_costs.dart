import 'package:intl/intl.dart';

import '../../general_exports.dart';

class UpfrontCosts extends StatelessWidget {
  const UpfrontCosts({
    super.key,
    this.results,
  });
  final dynamic results;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            FFLocalizations.of(context).getText('loan_summary'),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.02,
          ),
          ListView.builder(
            itemCount: results[keyLoanSummary].length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return LoanSummaryItem(
                item: results[keyLoanSummary][index],
              );
            },
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.05,
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
          Text(
            '${NumberFormat('#,##0.00').format(double.parse(results['monthlyPayment'] ?? 0))} ${getCurrency()}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: const Color(AppColors.primary),
                ),
          ),
          SizedBox(
            height: DEVICE_HEIGHT * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(AppColors.primary).withOpacity(0.03),
              borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: DEVICE_WIDTH * 0.015,
              vertical: DEVICE_HEIGHT * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(iconNote),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.02,
                ),
                Text(
                  results[keyNoteText] ?? '',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoanSummaryItem extends StatelessWidget {
  const LoanSummaryItem({
    super.key,
    this.item,
  });
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item[keyTitle] ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Row(
              children: [
                Text(
                  NumberFormat('#,##0.00')
                      .format(double.parse(item[keyPrice]))
                      .toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(AppColors.primary),
                      ),
                ),
                SizedBox(
                  width: DEVICE_WIDTH * 0.005,
                ),
                Text(
                  getCurrency(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: const Color(
                          AppColors.gray2,
                        ),
                      ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: DEVICE_HEIGHT * 0.01,
        ),
        Text(
          item[keySubtitle] ?? '',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color(AppColors.gray2),
              ),
        ),
        SizedBox(
          height: DEVICE_HEIGHT * 0.02,
        ),
        Container(
          height: DEVICE_HEIGHT * 0.001,
          width: DEVICE_WIDTH,
          color: const Color(AppColors.gray6),
        ),
        SizedBox(
          height: DEVICE_HEIGHT * 0.02,
        ),
      ],
    );
  }
}
