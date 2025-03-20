import '../../general_exports.dart';

class ChangeProfileInfo extends StatelessWidget {
  ChangeProfileInfo({
    super.key,
    this.onChangeInfo,
    this.firstName,
    this.lastName,
    this.email,
    this.nationalId,
    this.shouldShowNationalId = false,
    this.isNafathVerified = false,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? nationalId;
  final bool shouldShowNationalId;
  final bool isNafathVerified;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  final Function(
    String firstName,
    String lastName,
    String email,
    String nationalId,
  )? onChangeInfo;

  @override
  Widget build(BuildContext context) {
    if (firstName != null) {
      firstNameController.text = firstName!;
    }
    if (lastName != null) {
      lastNameController.text = lastName!;
    }
    if (email != null) {
      emailController.text = email!;
    }
    if (nationalId != null) {
      nationalIdController.text = nationalId!;
    }

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: firstNameController,
                      hint: FFLocalizations.of(context).getText('first_name'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: lastNameController,
                      hint: FFLocalizations.of(context).getText('last_name'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomInput(
                controller: emailController,
                hint: FFLocalizations.of(context).getText('email_address'),
              ),
              if (shouldShowNationalId)
                Column(
                  children: [
                    SizedBox(height: 10.h),
                    CustomInput(
                      controller: nationalIdController,
                      hint: FFLocalizations.of(context).getText('national_id'),
                      enabled: !isNafathVerified,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(
          width: DEVICE_WIDTH,
          child: CustomButton(
            text: FFLocalizations.of(context).getText('confirm'),
            onPressed: () {
              onChangeInfo!(
                firstNameController.text,
                lastNameController.text,
                emailController.text,
                nationalIdController.text,
              );
            },
          ),
        ),
      ],
    );
  }
}
