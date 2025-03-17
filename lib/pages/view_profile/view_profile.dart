import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewProfileModel>(
      create: (BuildContext context) => ViewProfileModel(),
      child: Consumer<ViewProfileModel>(
        builder: (
          BuildContext context,
          ViewProfileModel model,
          Widget? child,
        ) {
          return model.data == null ? const Center() : const ViewProfile();
        },
      ),
    );
  }
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 30.h,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                flex: 5,
                child: Profile(),
              ),
              SizedBox(
                width: 20.w,
              ),
              const Expanded(
                flex: 3,
                child: Settings(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewProfileModel viewProfileModel =
        Provider.of<ViewProfileModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      width: 300.w,
      height: MediaQuery.of(context).size.height - 450.h,
      decoration: BoxDecoration(
        color: FlutterMadaTheme.of(context).colorFFFFFF,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          MadaText(
            FFLocalizations.of(context).getText('view_profile'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: 50.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              10.r,
            ),
            child: Stack(
              children: <Widget>[
                CachedImage(
                  image: viewProfileModel.data?[keyProfilePic] ?? '',
                  height: 120.h,
                  width: 70.w,
                ),
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: viewProfileModel.pickImageAndUpload,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: FlutterMadaTheme.of(context)
                            .color8EC24D
                            .withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.h,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: viewProfileModel.pickImageAndUpload,
                    child: SvgPicture.asset(iconCamera),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          MadaText(
            FFLocalizations.of(context).getText('profile_info'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterMadaTheme.of(context).colorFFFFFF,
                borderRadius: BorderRadius.circular(10.h),
              ),
              child: Column(
                children: <Widget>[
                  ViewProfileCard(
                    text: FFLocalizations.of(context).getText('first_name'),
                    value: viewProfileModel.data[keyFirstName] ?? '',
                  ),
                  ViewProfileCard(
                    text: FFLocalizations.of(context).getText('last_name'),
                    value: viewProfileModel.data[keyLastName] ?? '',
                  ),
                  ViewProfileCard(
                    text: FFLocalizations.of(context).getText('email'),
                    value: viewProfileModel.data[keyEmail] ?? '',
                    withLine: false,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 150.w,
            child: CustomContainerButton(
              onPressed: () {
                viewProfileModel.onEditProfileInfo(context);
              },
              text: FFLocalizations.of(context).getText('edit_profile'),
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: FlutterMadaTheme.of(context).color8EC24D,
                  ),
              backgroundColor: FlutterMadaTheme.of(context).colorFFFFFF,
              borderColor: FlutterMadaTheme.of(context).color8EC24D,
              borderRadius: 10.r,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Spacer(),
          if (viewProfileModel.data[keyShowNafathSection] != null &&
              viewProfileModel.data[keyShowNafathSection])
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterMadaTheme.of(context).colorFAFAFA,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ViewProfileCard(
                    horizontalPadding: 20.w,
                    backGroundColor: Colors.transparent,
                    text: FFLocalizations.of(context).getText(
                      viewProfileModel.data[keyIsNafathVerified] == 0
                          ? 'verify_with_nafath'
                          : 'nafath_verified',
                    ),
                    withLine: false,
                    fontSize: 16,
                    image: imageNafath2,
                    onPressed: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .onNafathVerificationPress(context);
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewProfileModel viewProfileModel =
        Provider.of<ViewProfileModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      width: 300.w,
      height: MediaQuery.of(context).size.height - 450.h,
      decoration: BoxDecoration(
        color: FlutterMadaTheme.of(context).colorFFFFFF,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          MadaText(
            FFLocalizations.of(context).getText('settings'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(iconGlobal),
                        SizedBox(
                          width: 10.w,
                        ),
                        MadaText(
                          FFLocalizations.of(context).getText('language'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: FlutterMadaTheme.of(context).color000000,
                              ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            viewProfileModel.changeLanguage(context, 'en');
                          },
                          child: MadaText(
                            FFLocalizations.of(context).getText('english'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      FlutterMadaTheme.of(context).color000000,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                        if (FFAppState().getSelectedLanguge() == 'en')
                          SvgPicture.asset(iconToggleOffCircle),
                        TextButton(
                          onPressed: () {
                            viewProfileModel.changeLanguage(context, 'ar');
                          },
                          child: MadaText(
                            FFLocalizations.of(context).getText('arabic'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      FlutterMadaTheme.of(context).color000000,
                                ),
                          ),
                        ),
                        if (FFAppState().getSelectedLanguge() == 'ar')
                          SvgPicture.asset(iconToggleOffCircle),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: double.infinity,
            height: 2.h,
            color: FlutterMadaTheme.of(context).colorF5F5F5,
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: FlutterMadaTheme.of(context).colorFFFFFF,
              borderRadius: BorderRadius.circular(
                5.w,
              ),
            ),
            child: ProfileCategory(
              icon: iconLogout,
              text: FFLocalizations.of(context).getText('logout'),
              withArrow: false,
              fontSize: 16,
              onPressed: () {
                viewProfileModel.logout(context);
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: double.infinity,
            height: 2.h,
            color: FlutterMadaTheme.of(context).colorF5F5F5,
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: FlutterMadaTheme.of(context).colorFFFFFF,
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: ProfileCategory(
                icon: iconProfileDelete,
                text: FFLocalizations.of(context).getText('delete_account'),
                withLine: false,
                withArrow: false,
                fontSize: 16,
                onPressed: () {
                  viewProfileModel.onDeleteAccount(context);
                }),
          ),
        ],
      ),
    );
  }
}

class ProfileCategory extends StatelessWidget {
  const ProfileCategory({
    required this.text,
    required this.icon,
    super.key,
    this.onPressed,
    this.withLine = true,
    this.withArrow = true,
    this.fontSize,
    this.fontWeight,
  });
  final String text;
  final String icon;
  final Function()? onPressed;
  final bool withLine;
  final bool withArrow;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onPressed,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(icon),
                    SizedBox(
                      width: 10.w,
                    ),
                    MadaText(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: fontWeight ?? FontWeight.w400,
                            fontSize: fontSize ?? 15,
                            color: FlutterMadaTheme.of(context).color000000,
                          ),
                    )
                  ],
                ),
                if (withArrow)
                  RotatedBox(
                    quarterTurns: isRTL ? 2 : 0,
                    child: SvgPicture.asset(
                      iconArrowRight,
                      height: 18.h,
                      width: 16.w,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (withLine)
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
            ),
            child: Container(
              width: 100.w,
              height: 1.h,
              color: FlutterMadaTheme.of(context).colorF5F5F5,
            ),
          )
        else
          SizedBox(
            height: 10.h,
          ),
      ],
    );
  }
}

class ViewProfileCard extends StatelessWidget {
  const ViewProfileCard({
    required this.text,
    super.key,
    this.value,
    this.withLine = true,
    this.onPressed,
    this.fontSize,
    this.image,
    this.suffixIcon,
    this.valueWidth,
    this.backGroundColor,
    this.horizontalPadding,
  });
  final String text;
  final String? value;
  final bool withLine;
  final double? fontSize;
  final Function? onPressed;
  final String? image;
  final Widget? suffixIcon;
  final double? valueWidth;
  final Color? backGroundColor;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 5.w,
        right: 5.w,
        top: 35.h,
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              onPressed?.call();
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.w),
              color: backGroundColor ?? Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MadaText(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize ?? 15,
                        ),
                  ),
                  if (value != null)
                    Container(
                      alignment:
                          isRTL ? Alignment.centerLeft : Alignment.centerRight,
                      width: valueWidth ?? 180.w,
                      child: MadaText(
                        value!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                      ),
                    ),
                  if (image != null) Image.asset(image!),
                  if (suffixIcon != null) suffixIcon!,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (withLine)
            Padding(
              padding: EdgeInsets.only(
                top: 10.h,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1.h,
                color: FlutterMadaTheme.of(context).colorE1E1E1,
              ),
            )
          else
            SizedBox(
              height: 10.h,
            ),
        ],
      ),
    );
  }
}

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.textStyle,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    this.icon,
  });
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsets padding;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? backgroundColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              SvgPicture.asset(icon!),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: textStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountSheet extends StatelessWidget {
  const DeleteAccountSheet({
    super.key,
    this.onDeleteAccount,
  });

  final Function()? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: FlutterMadaTheme.of(context).colorFF0000.withValues(
                          alpha: 0.03,
                        ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 30.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(iconDeleteAccountWarning),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          FFLocalizations.of(context)
                              .getText('delete_account_desc'),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: FlutterMadaTheme.of(context).color000000,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          FFLocalizations.of(context).getText('delete_desc'),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: FlutterMadaTheme.of(context)
                                        .colorFF0000
                                        .withValues(
                                          alpha: 0.7,
                                        ),
                                    fontWeight: FontWeight.w500,
                                  ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomButton(
              text: FFLocalizations.of(context).getText('confirm_delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    FlutterMadaTheme.of(context).colorFF0000.withValues(
                          alpha: 0.15,
                        ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 10.w,
                ),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: FlutterMadaTheme.of(context).colorFF0000.withValues(
                          alpha: 1,
                        ),
                    fontWeight: FontWeight.w600,
                  ),
              onPressed: onDeleteAccount,
            ),
          ),
        ],
      ),
    );
  }
}
