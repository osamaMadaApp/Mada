import '../../general_exports.dart';
import '../../main.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewProfileModel>(
      create: (BuildContext context) => ViewProfileModel(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.h,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Profile(),
                SizedBox(
                  width: 20.w,
                ),
                const Settings(),
              ],
            ),
          ],
        ),
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
                  height: 20.h,
                  width: 20.w,
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
                            .withOpacity(0.4),
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
                            if (FFAppState().getSelectedLanguge() != 'en') {
                              FFAppState().update(() {
                                FFAppState().selectedLangugeAppState = 1;
                              });

                              MyApp.of(context).setLocale('en');
                              // should call master data again
                            }
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
                            if (FFAppState().getSelectedLanguge() != 'ar') {
                              FFAppState().update(() {
                                FFAppState().selectedLangugeAppState = 0;
                              });

                              MyApp.of(context).setLocale('ar');

                              // should call master data again
                            }
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
              // onPressed: myAppController.logout,
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
              // onPressed: controller.onDeleteAccount,
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
                            if (FFAppState().getSelectedLanguge() != 'en') {
                              FFAppState().update(() {
                                FFAppState().selectedLangugeAppState = 1;
                              });

                              MyApp.of(context).setLocale('en');
                              // should call master data again
                            }
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
                            if (FFAppState().getSelectedLanguge() != 'ar') {
                              FFAppState().update(() {
                                FFAppState().selectedLangugeAppState = 0;
                              });

                              MyApp.of(context).setLocale('ar');

                              // should call master data again
                            }
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
              // onPressed: myAppController.logout,
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
              // onPressed: controller.onDeleteAccount,
            ),
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

// class DeleteAccountSheet extends StatelessWidget {
//   const DeleteAccountSheet({
//     super.key,
//     this.onDeleteAccount,
//   });

//   final Function()? onDeleteAccount;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5.w),
//             // color: const Color(AppColors.red).withOpacity(0.03),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 10.w,
//               vertical: 5.h,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SvgPicture.asset(iconDeleteAccountWarning),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text(
//                   'delete_account_desc'.tr,
//                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                         color: const Color(AppColors.black),
//                         fontWeight: FontWeight.w400,
//                       ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.04,
//         ),
//         SizedBox(
//           width: DEVICE_WIDTH,
//           child: CustomButton(
//             text: 'confirm_delete'.tr,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(AppColors.red).withOpacity(0.15),
//               padding: EdgeInsets.symmetric(
//                 vertical: DEVICE_HEIGHT * 0.017,
//                 horizontal: DEVICE_WIDTH * 0.1,
//               ),
//               shadowColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.08),
//               ),
//             ),
//             textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: const Color(AppColors.red),
//                   fontWeight: FontWeight.w600,
//                 ),
//             onPressed: onDeleteAccount,
//           ),
//         ),
//         SizedBox(
//           height: DEVICE_HEIGHT * 0.02,
//         ),
//       ],
//     );
//   }
// }
