import 'package:flutter/services.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class NafathNumberSheet extends StatelessWidget {
  const NafathNumberSheet({
    super.key,
    this.nafathNumber = '',
  });

  final String nafathNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  FFLocalizations.of(context).getText('your_nafath_number'),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: 50.h),
                Text(
                  nafathNumber,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: FFLocalizations.of(context).getText('copy'),
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterMadaTheme.of(context).colorF4F4F4,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 10.w,
                    ),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: nafathNumber));
                    showToast(
                      FFLocalizations.of(context)
                          .getText('copied_to_clipboard'),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomButton(
              text: FFLocalizations.of(context).getText('close'),
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: FlutterMadaTheme.of(context).colorFFFFFF,
                  ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
