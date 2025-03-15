import 'package:country_flags/country_flags.dart';

import '../../general_exports.dart';
import '../../structure_main_flow/internationalization.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<NotificationsPageModel>(
          create: (BuildContext context) => NotificationsPageModel(),
        ),
      ],
      child: const Notifications(),
    );
  }
}

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsPageModel notificationsPageModel =
        Provider.of<NotificationsPageModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        FFLocalizations.of(context).getText('notifications'),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        FFLocalizations.of(context).getText('mada_properties'),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    // onTap: onCountryChange,
                    child: Container(
                      height: 50.w,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: FlutterMadaTheme.of(context).colorE6EEF3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 26.h,
                        horizontal: 10.w,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CountryFlag.fromCountryCode(
                          'sa',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 300.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 32.h,
                      ),
                      margin: EdgeInsets.only(top: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  SelectableCategory(
                                    text: FFLocalizations.of(context)
                                        .getText('new_notifications'),
                                    isSelected:
                                        notificationsPageModel.selectedScreen ==
                                            NotificationType.newNotifications,
                                    onTap: () {
                                      notificationsPageModel
                                          .onChangeCategoryPress(
                                        NotificationType.newNotifications,
                                      );
                                    },
                                  ),
                                  SizedBox(width: 8.w),
                                  SelectableCategory(
                                    text: FFLocalizations.of(context)
                                        .getText('read_notifications'),
                                    isSelected:
                                        notificationsPageModel.selectedScreen ==
                                            NotificationType.readNotifications,
                                    onTap: () {
                                      notificationsPageModel
                                          .onChangeCategoryPress(
                                        NotificationType.readNotifications,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (notificationsPageModel.isLoading == true)
                            const Center()
                          else
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: notificationsPageModel.onRefresh,
                                color: FlutterMadaTheme.of(context).primary,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller:
                                      notificationsPageModel.scrollController,
                                  padding: EdgeInsets.only(
                                    bottom: 1.h,
                                    top: 16.h,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      if (notificationsPageModel
                                          .notifications.isNotEmpty)
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(
                                            bottom: 1.h,
                                            top: 16.h,
                                          ),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: notificationsPageModel
                                              .notifications.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final dynamic item =
                                                notificationsPageModel
                                                    .notifications[index];
                                            return NotificationCard(
                                              item: item,
                                              isSelected: notificationsPageModel
                                                      .selectedNotification ==
                                                  item,
                                              onPress: () {
                                                notificationsPageModel
                                                    .onNotificationPress(
                                                  item,
                                                );
                                              },
                                            );
                                          },
                                        )
                                      else
                                        SizedBox(
                                          height: 5.h,
                                          child: Center(
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText('no_data'),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                    if (notificationsPageModel.selectedNotification != null)
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 32.h,
                            horizontal: 20.w,
                          ),
                          margin: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                FFLocalizations.of(context).getText(
                                  'notification_details',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(15.h),
                                    decoration: BoxDecoration(
                                      color: FlutterMadaTheme.of(context)
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        SvgPicture.asset(iconNewNotification),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    notificationsPageModel
                                            .selectedNotification[keyTitle] ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!,
                                  )
                                ],
                              ),
                              SizedBox(height: 40.h),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'details',
                                ),
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                notificationsPageModel
                                        .selectedNotification[keyDescription] ??
                                    '',
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              SizedBox(height: 40.h),
                              MadaText(
                                notificationsPageModel
                                        .selectedNotification[keyCreatedAt] ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: FlutterMadaTheme.of(context)
                                          .color8EC24D,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    this.item,
    this.showDescription = false,
    this.isClickable = true,
    this.isSelected = false,
    this.onPress,
  });

  final dynamic item;
  final bool showDescription;
  final bool isClickable;
  final bool isSelected;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: isSelected
              ? FlutterMadaTheme.of(context).primary.withOpacity(0.1)
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: GestureDetector(
              onTap: () {
                if (isClickable) {
                  onPress?.call();
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.02,
                        right: 0.h,
                        top: 2.h,
                        bottom: 1.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15.h),
                            decoration: BoxDecoration(
                              color: item[keyIsRead] == false
                                  ? FlutterMadaTheme.of(context)
                                      .primary
                                      .withOpacity(0.1)
                                  : FlutterMadaTheme.of(context)
                                      .color989898
                                      .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              item[keyIsRead] == false
                                  ? iconNewNotification
                                  : iconReadNotification,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item[keyTitle] ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: item[keyIsRead] == false
                                            ? Colors.black
                                            : FlutterMadaTheme.of(context)
                                                .color989898,
                                      ),
                                ),
                                if (showDescription)
                                  Text(
                                    item[keyDescription] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: item[keyIsRead] == false
                                              ? Colors.black
                                              : FlutterMadaTheme.of(context)
                                                  .color989898,
                                        ),
                                  ),
                                SizedBox(height: 22.h),
                                MadaText(
                                  item[keyCreatedAt] ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: item[keyIsRead] == false
                                            ? FlutterMadaTheme.of(context)
                                                .color8EC24D
                                            : FlutterMadaTheme.of(context)
                                                .color989898
                                                .withOpacity(0.5),
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 1.h,
          color: FlutterMadaTheme.of(context).colorF5F5F5,
        )
      ],
    );
  }
}
