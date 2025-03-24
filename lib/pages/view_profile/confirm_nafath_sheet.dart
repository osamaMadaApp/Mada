import '../../general_exports.dart';

class ConfirmNafathSheet extends StatelessWidget {
  const ConfirmNafathSheet({
    super.key,
    this.nafathNumber = '',
  });

  final String nafathNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FFLocalizations.of(context).getText('transfer_to_nafath'),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                Align(
                    child:
                        Image.asset(imageNafath, height: DEVICE_HEIGHT * 0.1)),
                SizedBox(height: DEVICE_HEIGHT * 0.05),
              ],
            ),
          ),
        ),
        SizedBox(
          width: DEVICE_WIDTH * 0.9,
          child: CustomButton(
            text: FFLocalizations.of(context).getText('confirm'),
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(AppColors.white),
                ),
            onPressed: () async {
              Navigator.pop(context);
              Provider.of<AppProvider>(context, listen: false)
                  .onNafathVerificationPress(context);
            },
          ),
        )
      ],
    );
  }
}
