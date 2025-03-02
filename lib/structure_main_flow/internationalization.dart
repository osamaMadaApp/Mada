import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // SplashPage
  {
    '60a4b1x8': {
      'en': 'Home',
      'ar': '',
    },
  },
  // MerchantLandingPage
  {
    'ktj21o5t': {
      'en': 'Ticket Type',
      'ar': 'نوع التذكرة',
    },
    'uq797x0c': {
      'en': 'From where?',
      'ar': 'من أين؟',
    },
    'pecwtixd': {
      'en': 'to Where ?',
      'ar': 'الى اين؟',
    },
    'kqjbnpph': {
      'en': '1 adult',
      'ar': '1 شخص بالغ',
    },
    'yhzhbmjn': {
      'en': 'Search',
      'ar': 'ابحث',
    },
    'cp4qczrf': {
      'en': 'Option 1',
      'ar': '',
    },
    'it7si7nn': {
      'en': 'Option 2',
      'ar': '',
    },
    'fl5ia27p': {
      'en': 'Option 3',
      'ar': '',
    },
    'bvmguu3a': {
      'en': 'Select...',
      'ar': '',
    },
    '9p6v87pw': {
      'en': 'Search...',
      'ar': '',
    },
    'ix03olyl': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AddAirlineTicketPage
  {
    '3d4gxh1o': {
      'en': 'Flight Number',
      'ar': 'رقم الرحلة الجوية',
    },
    'c5kw0fxv': {
      'en': 'Passenger Name',
      'ar': 'اسم الراكب',
    },
    'rlgeffh6': {
      'en': 'Hello World',
      'ar': '',
    },
    'e0c1jlow': {
      'en': 'Page Title',
      'ar': '',
    },
    '4dd0sfua': {
      'en': 'Home',
      'ar': '',
    },
  },
  // bluginPage
  {
    'mug8pl3i': {
      'en': 'Page Title',
      'ar': '',
    },
    'x9wj0e0v': {
      'en': 'Home',
      'ar': '',
    },
  },
  // LoginPage
  {
    'ezw44hnr': {
      'en': 'Page Title',
      'ar': '',
    },
    'bcdkouru': {
      'en': 'Sign in',
      'ar': 'تسجيل دخول',
    },
    '0wasfjru': {
      'en': 'Sign up',
      'ar': 'انشاء حساب',
    },
    'lggdo661': {
      'en': 'Home',
      'ar': '',
    },
  },
  // CompanyInformationPage
  {
    'hijuxkh5': {
      'en': 'Company Information',
      'ar': 'معلومات الشركة',
    },
    'wyrnlcon': {
      'en': 'Enter the required information about your company.',
      'ar': 'ادخل المعلومات المطلوبة عن الشركة',
    },
    're756qqc': {
      'en': 'Company Name',
      'ar': 'اسم الشركة',
    },
    'iizfyltt': {
      'en': 'Phone Number',
      'ar': 'رقم الهاتف',
    },
    'yx5yd3bh': {
      'en': 'Facility Number',
      'ar': 'رقم المنشأة',
    },
    '9d2h3871': {
      'en': 'Tourism license',
      'ar': 'رخصة السياحة',
    },
    'pc4pyxl9': {
      'en': 'Commercial register',
      'ar': 'السجل التجاري',
    },
    '9321hzlq': {
      'en': 'Update Company Profile',
      'ar': 'تحديث معلومات الشركة',
    },
    'd0cnejpp': {
      'en': 'Page Title',
      'ar': '',
    },
    'crlgxh4g': {
      'en': 'Home',
      'ar': '',
    },
  },
  // SubscriptionPage
  {
    'pq4iqhnj': {
      'en': 'Subscription Plan',
      'ar': 'خطة الاشتراك',
    },
    'xxnnrf9w': {
      'en': 'Select your subscription plan.',
      'ar': 'حدد خطة اشتراكك.',
    },
    'swxqfz4j': {
      'en': 'Free',
      'ar': 'مجاني',
    },
    'ydbwu8bw': {
      'en': 'Free trial for one month subscription',
      'ar': 'نسخة تجريبية مجانية للاشتراك لمدة شهر',
    },
    'y9tdtkk5': {
      'en': 'Free trial for one month only',
      'ar': 'تجربة مجانية لمدة شهر واحد فقط',
    },
    'ccxafa6p': {
      'en': 'Free',
      'ar': '',
    },
    '67qrr4x0': {
      'en': 'Free trial for one month subscription',
      'ar': '',
    },
    '28bg28li': {
      'en': 'Free trial for one month only',
      'ar': '',
    },
    'qwn8fs6s': {
      'en': 'Free',
      'ar': '',
    },
    'b4c0lqzl': {
      'en': 'Free trial for one month subscription',
      'ar': '',
    },
    '202blbzu': {
      'en': 'Free trial for one month only',
      'ar': '',
    },
    'i8sf2k0m': {
      'en': 'Continue',
      'ar': 'استكمال',
    },
    '8dwoguff': {
      'en': 'Page Title',
      'ar': '',
    },
    'wekdh85m': {
      'en': 'Home',
      'ar': '',
    },
  },
  // CreditCardDetailsPage
  {
    'nfusopjq': {
      'en': 'Credit card details',
      'ar': 'تفاصيل بطاقة الائتمان',
    },
    'emy1abg6': {
      'en': 'Price breakdown',
      'ar': 'تفاصيل السعر',
    },
    '3kju0p0y': {
      'en': 'Subscription type',
      'ar': 'نوع الاشتراك',
    },
    'pb6e5d6p': {
      'en': 'Monthly',
      'ar': 'شهري',
    },
    '1pothrf4': {
      'en': 'Subscription Fee',
      'ar': 'رسوم الاشتراك',
    },
    'd67eqnt3': {
      'en': 'Amount paid',
      'ar': 'المبلغ المدفوع',
    },
    'v7161yqj': {
      'en': 'Purchase',
      'ar': 'شراء',
    },
    '6klsrwpl': {
      'en': 'Page Title',
      'ar': '',
    },
    'qmeewtdo': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AdminLandingPage
  {
    'e3ikwwau': {
      'en': 'Total Metrics',
      'ar': 'مجموع الاحصائيات',
    },
    'gd2ihab1': {
      'en': 'An overview of Useres data...',
      'ar': 'نظرة عامة على بيانات المستخدمين...',
    },
    'i22kaoab': {
      'en': 'Total Donations',
      'ar': 'مجموع التبرعات',
    },
    '2y9ck2q4': {
      'en': 'Total Useres',
      'ar': 'إجمالي المستخدمين',
    },
    'bg7l6ydu': {
      'en': 'Total Events',
      'ar': 'مجموع الاحداث',
    },
    '7aufl9yt': {
      'en': 'Total Useres',
      'ar': 'إجمالي المستخدمين',
    },
    'uumweikx': {
      'en': 'Total Hotels Search',
      'ar': 'إجمالي البحث عن الفنادق',
    },
    '8q7b1dw3': {
      'en': 'Total Airlines Search',
      'ar': 'إجمالي البحث عن تذاكر الطيران',
    },
    'qtrevupp': {
      'en': 'Total Bugs',
      'ar': '',
    },
    'kvixf5ty': {
      'en': '4324',
      'ar': '',
    },
    '5lj2hxpr': {
      'en': 'Statuses % Distibution',
      'ar': '',
    },
    'c089aria': {
      'en': 'Statuses Count Distibution',
      'ar': '',
    },
    'yq52ictl': {
      'en': 'Types',
      'ar': 'الانواع',
    },
    'qr6wakf4': {
      'en': 'Statuses',
      'ar': 'الحالات',
    },
    'o8xmjvj9': {
      'en': 'Recent Activities',
      'ar': 'اخر الاحداث',
    },
    'ipwz0qjo': {
      'en': 'Activity Date',
      'ar': 'التاريخ الفعال',
    },
    'sdvn40du': {
      'en': 'User Name',
      'ar': 'اسم المستخدم',
    },
    'nsmfw3nb': {
      'en': 'Component',
      'ar': '',
    },
    'ia6bkau9': {
      'en': 'Component ID',
      'ar': '',
    },
    'cenp7qvc': {
      'en': 'Activity Type',
      'ar': 'النوع الفعال',
    },
    'c0d8ztan': {
      'en': 'Page Title',
      'ar': '',
    },
    'o662tg9e': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AdminUserDetailsPage
  {
    '1jwuxv40': {
      'en': 'Page Title',
      'ar': '',
    },
    'voajowm7': {
      'en': 'Merchant Info',
      'ar': 'معلومات التاجر',
    },
    'bhpimbbk': {
      'en': 'Name : ',
      'ar': 'اسم :',
    },
    '5wareasx': {
      'en': 'Email : ',
      'ar': 'بريد إلكتروني :',
    },
    'nflrg76c': {
      'en': 'Approve account : ',
      'ar': 'الموافقة على الحساب :',
    },
    'rgzjrcox': {
      'en': 'Subscription Info ',
      'ar': 'معلومات الاشتراك',
    },
    'n33s1hlk': {
      'en': 'Subscription Type : ',
      'ar': 'نوع الاشتراك :',
    },
    '8cctgp46': {
      'en': 'Subscription Date : ',
      'ar': 'تاريخ الاشتراك :',
    },
    'u42c0jfw': {
      'en': 'Expiration Date : ',
      'ar': 'تاريخ انتهاء الصلاحية :',
    },
    '502i3bkw': {
      'en': 'Company Info',
      'ar': 'معلومات الشركة',
    },
    '3cqmuqev': {
      'en': 'Name : ',
      'ar': 'اسم :',
    },
    'op947s9b': {
      'en': '',
      'ar': '',
    },
    'gb0b9h54': {
      'en': 'Phone Number : ',
      'ar': 'رقم التليفون :',
    },
    'wkxkqr25': {
      'en': '',
      'ar': '',
    },
    'igow3wsa': {
      'en': 'Facility Number : ',
      'ar': 'رقم المنشأة :',
    },
    'uhejeal7': {
      'en': '',
      'ar': '',
    },
    '36cu9z05': {
      'en': 'Tourism License :',
      'ar': 'رخصة السياحة:',
    },
    '3qrcn76r': {
      'en': 'Commercial Register :',
      'ar': 'السجل التجاري :',
    },
    'vc0z42xk': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AdminUserPage
  {
    '3r5nw8d7': {
      'en': 'Search',
      'ar': 'البحث',
    },
    '686n81yh': {
      'en': 'Name',
      'ar': 'الاسم',
    },
    '6wu41tvo': {
      'en': 'Email',
      'ar': 'الايميل',
    },
    'nr0pxvy6': {
      'en': 'Status',
      'ar': 'الحالة',
    },
    '7k87njh6': {
      'en': 'View and edit',
      'ar': 'مشاهدة وتعديل',
    },
    '4zilt1o9': {
      'en': 'Page Title',
      'ar': '',
    },
    'ldnh28xh': {
      'en': 'Home',
      'ar': '',
    },
  },
  // CitiesPage
  {
    'xckyr0rr': {
      'en': 'Search',
      'ar': '',
    },
    'k1rnglzr': {
      'en': 'Name',
      'ar': '',
    },
    'yr35peeu': {
      'en': 'Email',
      'ar': '',
    },
    'kiqnwmsf': {
      'en': 'Status',
      'ar': '',
    },
    'cvz7dvx5': {
      'en': 'View and edit',
      'ar': '',
    },
    'syf4gufi': {
      'en': 'Page Title',
      'ar': '',
    },
    'lsv7ndyr': {
      'en': 'Home',
      'ar': '',
    },
  },
  // CitiesDetailsPage
  {
    'i6se5obr': {
      'en': 'Page Title',
      'ar': '',
    },
    'kaf14x8g': {
      'en': 'City Name',
      'ar': 'اسم المدينة',
    },
    'sw4qxi9x': {
      'en': 'City Name Ar',
      'ar': 'اسم المدينة بالعربية',
    },
    'in7g0dax': {
      'en': 'City Name En',
      'ar': 'اسم المدينة باللغة الإنجليزية',
    },
    'ym9bw4ms': {
      'en': 'Country Name',
      'ar': 'اسم الدولة',
    },
    'vmelm0gx': {
      'en': 'Country Name Ar',
      'ar': 'اسم الدولة Ar',
    },
    'hqt9qdnv': {
      'en': 'Country Name En',
      'ar': 'اسم الدولة باللغة الإنجليزية',
    },
    'iws9ojd3': {
      'en': 'Two Digits Country Code',
      'ar': 'رمز الدولة المكون من رقمين',
    },
    'bp0h24r8': {
      'en': 'Code',
      'ar': 'شفرة',
    },
    '4wpcoarj': {
      'en': 'Three Digits Country Code',
      'ar': 'رمز الدولة المكون من ثلاثة أرقام',
    },
    'orufw0y9': {
      'en': 'Code',
      'ar': 'شفرة',
    },
    '10pux63g': {
      'en': 'Home',
      'ar': '',
    },
  },
  // HotelsEditPage
  {
    'tpua3opt': {
      'en': 'Add Hotels Reservations',
      'ar': 'إضافة حجوزات الفنادق',
    },
    '8btl2bfm': {
      'en': 'select or inset the required data to the Hotels Reservations',
      'ar': 'حدد أو أدخل البيانات المطلوبة في حجوزات الفنادق',
    },
    'q2v210ry': {
      'en': 'Ticket details',
      'ar': 'تفاصيل التذكرة',
    },
    'w5c2b5mu': {
      'en': 'Select Hotel',
      'ar': 'اختر الفندق',
    },
    'am9q8r8h': {
      'en': 'Reservation Date',
      'ar': 'تاريخ الحجز',
    },
    'qw6gzjfl': {
      'en': 'Arrival Date',
      'ar': 'تاريخ الوصول',
    },
    'mrsxiyf4': {
      'en': 'Reservation Time',
      'ar': 'وقت الحجز',
    },
    '5m44c7kh': {
      'en': 'Arrival Time',
      'ar': 'وقت الوصول',
    },
    'd79rznbc': {
      'en': 'Quantity',
      'ar': 'كمية',
    },
    'ndfopgbq': {
      'en': 'Room Class',
      'ar': 'فئة الغرفة',
    },
    'hdqam4u0': {
      'en': 'Price',
      'ar': 'سعر',
    },
    'n3csh2ej': {
      'en': 'Transportation',
      'ar': 'مواصلات',
    },
    '6z2qmgag': {
      'en': 'Transportation Class',
      'ar': 'فئة النقل',
    },
    'k0het2k7': {
      'en': 'Confirm',
      'ar': 'تأكيد',
    },
    'ldrn35wn': {
      'en': 'Home',
      'ar': '',
    },
  },
  // SignInComponent
  {
    'ute2nvcz': {
      'en': 'Sign in to BlockToBook',
      'ar': 'سجل دخولك لبلوك تو بوك',
    },
    'bved7bq8': {
      'en': 'Sign in using your email address below to get started.',
      'ar': 'قم بتسجيل الدخول باستخدام بريدك الالكتروني',
    },
    'jl8mq61h': {
      'en': 'Email',
      'ar': 'البريد الالكتروني',
    },
    'rkiolrk3': {
      'en': 'Password',
      'ar': 'كلمة السر',
    },
    'pmygkcma': {
      'en': 'Forget Password',
      'ar': 'نسيت كلمة السر',
    },
    '20gukkxk': {
      'en': 'Login to your account',
      'ar': 'تسجيل الدخول لحسابك',
    },
  },
  // SignUpComponent
  {
    'yz7gxbfk': {
      'en': 'SignUp to BlockToBook',
      'ar': '',
    },
    'grgwpkoc': {
      'en': 'SignUp using your email address below to get started.',
      'ar': '',
    },
    'tjgwczr1': {
      'en': 'Email',
      'ar': '',
    },
    '9akbocm9': {
      'en': 'Password',
      'ar': '',
    },
    'o1f0gl0b': {
      'en': 'I agree to the',
      'ar': '',
    },
    'vv7isl41': {
      'en': 'Terms and conditions',
      'ar': '',
    },
    'mi7g0z7p': {
      'en': 'Send me the latest deal alerts',
      'ar': '',
    },
    'e5l0b8bx': {
      'en': 'Create account',
      'ar': '',
    },
  },
  // ForgetPassword
  {
    '50xuhnxw': {
      'en': 'Reset Password',
      'ar': 'اعادة تعيين كلمة السر',
    },
    '38yrvr4a': {
      'en': 'Add your email to receive link to reset password',
      'ar': 'قم باضافة البريد الالكتروني لاعادة تعيين كلمة السر',
    },
    'qbsclh5c': {
      'en': 'Email',
      'ar': '',
    },
    'io1m2w6h': {
      'en': 'Last known password',
      'ar': 'كلمة السر الاخيرة',
    },
    '2mb6bn75': {
      'en': 'Reset Password',
      'ar': 'اعادة تعيين كلمة السر',
    },
  },
  // BottomWebComponent
  {
    'fpfkq2m6': {
      'en': 'About',
      'ar': 'اعرف عنا',
    },
    'ts8y7np7': {
      'en': 'About BlockToBook',
      'ar': 'عن بلوك تو بوك',
    },
    's0lrofea': {
      'en': 'How it work',
      'ar': 'كيف يعمل',
    },
    '165aptt6': {
      'en': 'Partner with us',
      'ar': 'تشارك معنا',
    },
    'ihg69ll5': {
      'en': 'Partnership programs',
      'ar': 'برنامج التشارك',
    },
    'deze8xa9': {
      'en': 'Support',
      'ar': 'الدعم',
    },
    'z3t9hie4': {
      'en': 'Help Center',
      'ar': 'مركز الخدمة',
    },
    't22t8k9c': {
      'en': 'Contact us',
      'ar': 'تواصل معنا',
    },
    'woeimonb': {
      'en': 'Privacy policy',
      'ar': 'سياسة الخصوصية',
    },
    '5fajc3lq': {
      'en': 'Terms of service',
      'ar': 'شروط الخدمة',
    },
    '4vdz8a42': {
      'en': 'Trust and safety',
      'ar': 'الثقة والأمان',
    },
    'xh271m1z': {
      'en': 'Get the app',
      'ar': 'احصل على التطبيق',
    },
    'rykck37x': {
      'en': 'Android',
      'ar': 'الاندرويد',
    },
    'va6t92pc': {
      'en': 'Ios',
      'ar': 'الايفون',
    },
  },
  // SideMenuComponent
  {
    '4zgejs1j': {
      'en': 'Merchants  Informations',
      'ar': 'معلومات التجار',
    },
    '9fdln0o0': {
      'en': 'Orders',
      'ar': '',
    },
    '6dim3f5h': {
      'en': 'Logout',
      'ar': '',
    },
  },
  // PublicProgressComponent
  {
    'd8xb2ak5': {
      'en': '',
      'ar': '',
    },
  },
  // ViewImageComponent
  {
    '35f3ndm6': {
      'en': 'Close',
      'ar': 'يغلق',
    },
  },
  // Merchant_top_bar
  {
    '7jqhwabv': {
      'en': 'Search',
      'ar': 'البحث',
    },
    '8vx9xnau': {
      'en': 'Orders',
      'ar': 'طلبات',
    },
    'k7wxbner': {
      'en': 'Hotels',
      'ar': 'الفنادق',
    },
    '1qdhkegw': {
      'en': 'Airlines',
      'ar': 'شركات الطيران',
    },
    't90tz7al': {
      'en': 'Cart',
      'ar': 'العربة',
    },
    '7bnjktpv': {
      'en': '150.00',
      'ar': '',
    },
  },
  // FilterComponent
  {
    'wy4bwaca': {
      'en': 'Filters',
      'ar': 'المرشحات',
    },
    'm86ceyii': {
      'en': 'Reset All',
      'ar': 'إعادة تعيين الكل',
    },
    '8smvgf6i': {
      'en': 'Apply',
      'ar': 'فلتره',
    },
    'gyo3cig8': {
      'en': 'Filter By Visibility',
      'ar': 'تصفية حسب الرؤية',
    },
    'doz9m0zq': {
      'en': 'Expanded body text',
      'ar': '',
    },
    '81spvmp1': {
      'en': 'Is Visibile',
      'ar': '',
    },
    '2ct8w3xn': {
      'en': 'Filter By Date',
      'ar': 'تصفية حسب التاريخ',
    },
    '562mh6mr': {
      'en': 'From',
      'ar': 'من',
    },
    'drikntu9': {
      'en': 'To',
      'ar': 'ل',
    },
    'vk5jfjti': {
      'en': 'Expanded body text',
      'ar': '',
    },
    'y7vlbuo1': {
      'en': 'Price',
      'ar': '',
    },
    '2yu2zzfv': {
      'en': '',
      'ar': '',
    },
    'bbnb4kmo': {
      'en': '',
      'ar': '',
    },
    'bg7jssmm': {
      'en': 'Expanded body text',
      'ar': '',
    },
    '1uhyxnaa': {
      'en': 'Hotels',
      'ar': 'الفنادق',
    },
    'v86fnph1': {
      'en': 'Add ',
      'ar': 'اضافة',
    },
  },
  // HotelGridFilter
  {
    '0t2hcmg4': {
      'en': 'Popular Cities',
      'ar': 'المدن المشهورة',
    },
    'p1hog9t9': {
      'en': 'Hello World',
      'ar': '',
    },
    'h0w3m1ih': {
      'en': 'Hello World',
      'ar': '',
    },
  },
  // PaymentPopUpComponent
  {
    'wh9190d3': {
      'en': 'Payment',
      'ar': 'الدفع',
    },
    '9o1plflm': {
      'en': 'All transactions are secure and encrypted',
      'ar': 'جميع المعاملات آمنة ومشفرة',
    },
    'xwpwz678': {
      'en': 'Include my points 50.0 JD',
      'ar': '',
    },
    'cuhqj835': {
      'en': 'Credit card',
      'ar': '',
    },
    '01pjwu6q': {
      'en': 'Recharge By Block To Book',
      'ar': '',
    },
    '0pa3hjss': {
      'en': 'Buy With Current Amount',
      'ar': '',
    },
    'uuv464gt': {
      'en': '50.0 JD',
      'ar': '',
    },
    'znk69pzc': {
      'en': 'Recharge',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    '5omay1a0': {
      'en': '',
      'ar': '',
    },
    'suib8c3d': {
      'en': '',
      'ar': '',
    },
    'iol0pbcl': {
      'en': '',
      'ar': '',
    },
    '19ckcaip': {
      'en': '',
      'ar': '',
    },
    'rjqpv7zv': {
      'en': '',
      'ar': '',
    },
    'n64gow9q': {
      'en': '',
      'ar': '',
    },
    'lsf3o1p8': {
      'en': '',
      'ar': '',
    },
    'gssqe8r7': {
      'en': '',
      'ar': '',
    },
    'aydbzz7u': {
      'en': '',
      'ar': '',
    },
    'uzllnbs6': {
      'en': '',
      'ar': '',
    },
    'cbyaa61p': {
      'en': '',
      'ar': '',
    },
    '44tbhrfm': {
      'en': '',
      'ar': '',
    },
    'fot1716d': {
      'en': '',
      'ar': '',
    },
    '79shbo97': {
      'en': '',
      'ar': '',
    },
    'wpfqija4': {
      'en': '',
      'ar': '',
    },
    '6exfwl3p': {
      'en': '',
      'ar': '',
    },
    'jnhyvp51': {
      'en': '',
      'ar': '',
    },
    'mf1o15g4': {
      'en': '',
      'ar': '',
    },
    '0m8f7l97': {
      'en': '',
      'ar': '',
    },
    'l2xuef7n': {
      'en': '',
      'ar': '',
    },
    'j032nmzz': {
      'en': '',
      'ar': '',
    },
    't20px7ce': {
      'en': '',
      'ar': '',
    },
    'ex6uvvp4': {
      'en': '',
      'ar': '',
    },
    'ngz7i433': {
      'en': '',
      'ar': '',
    },
    'huu7vuok': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
