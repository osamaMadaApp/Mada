import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => <String>['en', 'ar'];

  static late SharedPreferences _prefs;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);

  static Locale? getStoredLocale() {
    final String? locale = _prefs.getString(_kLocaleStorageKey);
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
      (kTranslationsMap[key] ?? <String, String>{})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      <String?>[enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = <String>{
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
    final String language = locale.toString();
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

final Map<String, Map<String, String>> kTranslationsMap =
    <Map<String, Map<String, String>>>[
  // LoginPage
  <String, Map<String, String>>{
    'login': <String, String>{
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'enterEmail': <String, String>{
      'en': 'Enter your e-mail address to login',
      'ar': 'قم بادخال الايميل لتسجيل الدخول',
    },
    'forgetPassword': <String, String>{
      'en': 'Forget Password',
      'ar': 'نسيت كلمة السر',
    },
    'rest': <String, String>{
      'en': 'Enter your e-mail address to rest password',
      'ar': 'قم بادخال ايميلك لعادة تعيين كلمة السر',
    },
    'backToLogin': <String, String>{
      'en': 'Back to login',
      'ar': 'العودة الى تسجيل الدخول',
    },
    'confirm': <String, String>{
      'en': 'Confirm',
      'ar': 'تأكيد',
    },
    'fillEmptyForm': <String, String>{
      'en': 'Input Field is required',
      'ar': 'يرجى تعبئة الحقل الفارغ',
    },
    'emailIsNoValid': <String, String>{
      'en': 'Input Field Email Is Not Valid',
      'ar': 'حقل الإدخال البريد الإلكتروني غير صالح',
    },
    'emailAddress': <String, String>{
      'en': 'E-mail Address',
      'ar': 'البريد الالكتروني',
    },
    'forgetPassword?': <String, String>{
      'en': 'Forget Password?',
      'ar': 'هل نسيت كلمة السر؟',
    },
    'password': <String, String>{
      'en': 'Password',
      'ar': 'كلمة السر',
    },
    'bcdkouru': <String, String>{
      'en': 'Sign in',
      'ar': 'تسجيل دخول',
    },
    '0wasfjru': <String, String>{
      'en': 'Sign up',
      'ar': 'انشاء حساب',
    },
    'lggdo661': <String, String>{
      'en': 'Home',
      'ar': '',
    },
    'off': <String, String>{
      'en': 'of',
      'ar': 'من',
    },
    'code': <String, String>{
      'en': 'Code Verification',
      'ar': 'التحقق من الرمز',
    },
    'enter': <String, String>{
      'en': 'Enter the code that we sent to you on E-mail address',
      'ar': 'ادخل الرمز المرسل الى بريدك الالكتروني',
    },
    'resend': <String, String>{
      'en': 'Resend the code',
      'ar': 'اعادة ارسال الرمز',
    },
    'your_gateway_to_premium_life': <String, String>{
      'en': 'Your gateway to premium life',
      'ar': 'بوابتك إلى الحياة المتميزة',
    },
    'browse_out_main_categories': <String, String>{
      'en': 'Browse our main categories',
      'ar': 'تصفح الفئات الرئيسية لدينا',
    },
    'most_popular_projects': <String, String>{
      'en': 'Most popular projects',
      'ar': 'المشاريع الأكثر شعبية',
    },
    'view_profile': <String, String>{
      'en': 'View Profile',
      'ar': 'عرض الملف الشخصي',
    },
    'favorites': <String, String>{
      'en': 'Favorites',
      'ar': 'المفضلة',
    },
    'contact_us': <String, String>{
      'en': 'Contact Us',
      'ar': 'اتصل بنا',
    },
    'terms_and_conditions': <String, String>{
      'en': 'Terms And conditions',
      'ar': 'الشروط والأحكام',
    },
    'fal_license_awards': <String, String>{
      'en': 'FAL license & awards',
      'ar': 'رخصة فال & والجوائز',
    },
    'menu': <String, String>{
      'en': 'Menu',
      'ar': 'القائمة',
    },
    'mada_properties': <String, String>{
      'en': 'MADA Properties',
      'ar': 'مدى العقارية',
    },
    'settings': <String, String>{
      'en': 'Settings',
      'ar': 'الاعدادات',
    },
    'logout': <String, String>{
      'en': 'Logout',
      'ar': 'تسجيل الخروج',
    },
    'delete_account': <String, String>{
      'en': 'Delete Account',
      'ar': 'حذف الحساب',
    },
    'language': <String, String>{
      'en': 'Language',
      'ar': 'اللغة',
    },
    'english': <String, String>{
      'en': 'English',
      'ar': 'الإنجليزية',
    },
    'arabic': <String, String>{
      'en': 'Arabic',
      'ar': 'العربية',
    },
    'profile_info': <String, String>{
      'en': 'Profile Info.',
      'ar': 'معلومات الحساب',
    },
    'first_name': <String, String>{
      'en': 'First Name',
      'ar': 'الاسم الأول',
    },
    'last_name': <String, String>{
      'en': 'Last Name',
      'ar': 'اسم العائلة',
    },
    'email': <String, String>{
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
    },
    'verify_with_nafath': <String, String>{
      'en': 'Verify with Nafath',
      'ar': 'التحقق مع نفاذ',
    },
    'nafath_verified': <String, String>{
      'en': 'Nafath Verified',
      'ar': 'تم التحقق من نفاذ',
    },
    'my_orders': <String, String>{
      'en': 'My Orders',
      'ar': 'طلباتي',
    },
    'no_data_found': <String, String>{
      'en': 'No data found',
      'ar': 'لم يتم العثور على بيانات',
    },
    'change_password': <String, String>{
      'en': 'Change password',
      'ar': 'تغيير كلمة المرور',
    },
    'edit_profile': <String, String>{
      'en': 'Edit profile',
      'ar': 'تعديل الملف الشخصي',
    },
    'exclusive_projects': <String, String>{
      'en': 'Exclusive projects',
      'ar': 'مشاريع حصرية',
    },
    'projects_categories': <String, String>{
      'en': 'Projects Categories',
      'ar': 'فئات المشاريع',
    },
    'latest_projects': <String, String>{
      'en': 'Latest Projects',
      'ar': 'أحدث المشاريع',
    },
    'available': <String, String>{
      'en': 'Available',
      'ar': 'متاح',
    },
    'of': <String, String>{
      'en': 'of',
      'ar': 'ل',
    },
    'result': <String, String>{
      'en': 'Result: ',
      'ar': 'الناتج: ',
    },
    'project': <String, String>{
      'en': 'Project',
      'ar': 'مشروع',
    },
    'hi': <String, String>{
      'en': 'Hi',
      'ar': 'مرحبا',
    },
    'hi_guest': <String, String>{
      'en': 'Hi Guest',
      'ar': 'مرحبا بالضيف',
    },
    'notifications': <String, String>{
      'en': 'Notifications',
      'ar': 'الإشعارات',
    },
    'new_notifications': <String, String>{
      'en': 'New Notifications',
      'ar': 'إشعارات جديدة',
    },
    'read_notifications': <String, String>{
      'en': 'Read Notifications',
      'ar': 'قراءة الإشعارات',
    },
    'notification_details': <String, String>{
      'en': 'Notification Details',
      'ar': 'تفاصيل الإشعار',
    },
    'details': <String, String>{
      'en': 'Details',
      'ar': 'تفاصيل',
    },
    'exclusive_units': <String, String>{
      'en': 'Exclusive Units',
      'ar': 'وحدات حصرية',
    },
    'other_units': <String, String>{
      'en': 'Other Units',
      'ar': 'وحدات أخرى',
    },
    'order_id': <String, String>{
      'en': 'Order ID',
      'ar': 'رقم الطلب',
    },
    'date': <String, String>{
      'en': 'Date',
      'ar': 'تاريخ',
    },
    'phone': <String, String>{
      'en': 'Phone',
      'ar': 'الهاتف',
    },
    'whatsapp': <String, String>{
      'en': 'Whatsapp',
      'ar': 'واتساب',
    },
    '360_view': <String, String>{
      'en': '360 View',
      'ar': 'عرض 360',
    },
    'delete_account_desc': <String, String>{
      'en': 'Are you sure you want to delete your account?',
      'ar': 'هل أنت متأكد أنك تريد حذف حسابك؟',
    },
    'confirm_delete': <String, String>{
      'en': 'Confirm Delete',
      'ar': 'تأكيد الحذف',
    },
    'sqft': <String, String>{
      'en': 'Sqft',
      'ar': 'قدم مربع',
    },
    'quick_filter': <String, String>{
      'en': 'Quick filter',
      'ar': 'البحث المتقدم',
    },
    'edit_filter': <String, String>{
      'en': 'Edit Filter',
      'ar': 'تعديل الفلتر',
    },
    'add_custom_filter': <String, String>{
      'en': 'Add Custom Filter',
      'ar': 'إضافة فلتر مخصص',
    },
    'reset_filter': <String, String>{
      'en': 'Reset filter',
      'ar': 'إعادة تعيين الفلتر',
    },
    'project_result': <String, String>{
      'en': 'Project Result',
      'ar': 'نتيجة البحث',
    },
    'awards_achievements': <String, String>{
      'en': 'Awards and Achivements',
      'ar': 'الجوائز والإنجازات',
    },
    'fal_license': <String, String>{
      'en': 'FAL Licence',
      'ar': 'رخصة فال',
    },
    'success_download': <String, String>{
      'en': 'Success Download',
      'ar': 'تم التنزيل بنجاح',
    },
    'purpose_of_use': <String, String>{
      'en': 'Purpose of use',
      'ar': 'غرض الاستخدام',
    },
    'project_categories': <String, String>{
      'en': 'Project categories',
      'ar': 'نوع المشروع',
    },
    'please_select_city': <String, String>{
      'en': 'Please select the city',
      'ar': 'يرجى اختيار المدينة',
    },
    'the_neighborhood': <String, String>{
      'en': 'The neighborhood',
      'ar': 'الحي',
    },
    'bedrooms': <String, String>{
      'en': 'Bedrooms',
      'ar': 'غرف النوم',
    },
    'price': <String, String>{
      'en': 'Price',
      'ar': 'السعر',
    },
    'min': <String, String>{
      'en': 'Min',
      'ar': 'الحد الأدنى',
    },
    'max': <String, String>{
      'en': 'Max',
      'ar': 'الحد الأقصى',
    },
    'area': <String, String>{
      'en': 'Area',
      'ar': 'منطقة',
    },
    'real_estate_developer': <String, String>{
      'en': 'Real estate developer',
      'ar': 'المطور العقاري',
    },
    'apply_filter': <String, String>{
      'en': 'Apply filter',
      'ar': 'تطبيق الفلتر',
    },
    'nafath_already_verified': <String, String>{
      'en': 'NAFATH already verified',
      'ar': 'تم التحقق من نفاذ بالفعل',
    },
    'please_confirm_nafath': <String, String>{
      'en': 'Please confirm NAFATH',
      'ar': 'يرجى تأكيد نفاذ',
    },
    'nafath_number': <String, String>{
      'en': 'Nafath number',
      'ar': 'رقم نفاذ',
    },
    'copy': <String, String>{
      'en': 'Copy',
      'ar': 'نسخ',
    },
    'your_nafath_number': <String, String>{
      'en': 'ٌYour Nafath Number',
      'ar': 'رقم نفاذ الخاص بك',
    },
    'copied_to_clipboard': <String, String>{
      'en': 'ٌCopied to clipboard',
      'ar': 'تم النسخ إلى الحافظة',
    },
    'close': <String, String>{
      'en': 'ٌClose',
      'ar': 'اغلاق',
    },
    'change_profile_info': <String, String>{
      'en': 'Change profile info.',
      'ar': 'تغيير معلومات الملف الشخصي',
    },
    'email_address': <String, String>{
      'en': 'Email addreess',
      'ar': 'عنوان البريد الإلكتروني',
    },
    'national_id': <String, String>{
      'en': 'National id',
      'ar': 'رقم الهوية الوطنية',
    },
    'please_fill_profile_info': <String, String>{
      'en': 'Please fill profile info',
      'ar': 'يرجى ملء معلومات الملف الشخصي',
    },
    'delete_account_!': <String, String>{
      'en': 'Delete Account !!',
      'ar': 'حذف الحساب !!',
    },
    'individuals': <String, String>{
      'en': 'Individuals',
      'ar': 'الأفراد',
    },
    'companies': <String, String>{
      'en': 'Companies',
      'ar': 'الشركات',
    },
    'please_enter_valid_number': <String, String>{
      'en': 'Please enter a valid number',
      'ar': 'الرجاء إدخال رقم صحيح',
    },
    'msg_title': <String, String>{
      'en': 'Msg title',
      'ar': 'عنوان الرسالة',
    },
    'type_msg': <String, String>{
      'en': 'Type msg ...',
      'ar': 'عنوان الرسالة',
    },
    'send': <String, String>{
      'en': 'Send',
      'ar': 'إرسال',
    },
    'company_name': <String, String>{
      'en': 'Company name',
      'ar': 'اسم الشركة',
    },
    'employee_name': <String, String>{
      'en': 'Employee name',
      'ar': 'اسم الموظف',
    },
    'employee_position': <String, String>{
      'en': 'Employee position',
      'ar': 'منصب الموظف',
    },
    'contact_info': <String, String>{
      'en': 'Contact Info',
      'ar': 'معلومات الاتصال',
    },
    'custom_filter': <String, String>{
      'en': 'Custom Filter',
      'ar': 'فلتر مخصص',
    },
    'delete_desc': <String, String>{
      'en':
          'By performing Delete We regret to inform you that your account will be scheduled for permanent deletion within the next two weeks. During this period, you will be logged out from Mada App. Please note that if you log in again, the deletion process will be halted.',
      'ar':
          'بإجراء عملية حذف، يؤسفنا إبلاغك بأنه سيتم حذف حسابك نهائيًا خلال الأسبوعين القادمين. خلال هذه الفترة، سيتم تسجيل خروجك من تطبيق مدى. يُرجى العلم أنه في حال تسجيل الدخول مرة أخرى، سيتم إيقاف عملية الحذف.',
    },
    'quick_filter': <String, String>{
      'en': 'Quick Filter',
      'ar': 'تصفية سريعة',
    },
    'city_neighborhood': <String, String>{
      'en': 'City & Neighborhood',
      'ar': 'المدينة والحي',
    },
    'property_type_use': <String, String>{
      'en': 'Property Type & Use',
      'ar': 'نوع العقار والاستخدام',
    },
    'beds_baths': <String, String>{
      'en': 'Beds & Baths',
      'ar': 'الغرف والحمامات',
    },
    'any': <String, String>{
      'en': 'Any',
      'ar': 'أي',
    },
    'search_for_units': <String, String>{
      'en': 'Search for units',
      'ar': 'البحث عن وحدات',
    },
    'download_property_pdf': <String, String>{
      'en': 'Download property PDF',
      'ar': 'تنزيل ملف بي دي أَف الخاص بهذا العقار',
    },
    'follow': <String, String>{
      'en': 'Follow',
      'ar': 'متابعة',
    },
    'price_starts': <String, String>{
      'en': 'Price Starts',
      'ar': 'السعر يبدأ من',
    },
    'mortgage_calculator': <String, String>{
      'en': 'Mortagage Calculator',
      'ar': 'حاسبة الرهن العقاري',
    },
    'month': <String, String>{
      'en': 'Month',
      'ar': 'شهر',
    },
    'estimates_your_monthly_mortgage_payments': <String, String>{
      'en': 'Estimates your monthly mortgage payments',
      'ar': 'حساب الأقساط الشهرية الخاصة بك',
    },
    'property_price': {
      'en': 'Property Price',
      'ar': 'سعر العقار',
    },
    'loan_term': {
      'en': 'Loan Term',
      'ar': 'مدة القرض',
    },
    'years': {
      'en': 'Years',
      'ar': 'سنوات',
    },
    'loan_term_must_be_2_years': {
      'en': 'Loan term must be at least 2 years',
      'ar': 'يجب أن تكون مدة القرض سنتين على الأقل'
    },
    'down_payment': {
      'en': 'Down Payment',
      'ar': 'الدفعة الأولى',
    },
    'down_payment_must_be_at_least': {
      'en': 'Down payment must be at least',
      'ar': 'يجب أن تكون الدفعة الأولى على الأقل'
    },
    'percentage': {
      'en': 'Percentage',
      'ar': 'النسبة المئوية',
    },
    'interest_rate': {
      'en': 'Interest Rate',
      'ar': 'معدل الفائدة',
    },
    'monthly_payment': {
      'en': 'Monthly Payment',
      'ar': 'الدفع الشهري',
    },
    'view_upfront_costs': {
      'en': 'View Upfront Costs',
      'ar': 'عرض التكاليف المسبقة'
    },
    '%': {
      'en': '%',
      'ar': '%',
    },
    'loan_summary': {
      'en': 'Loan Summary',
      'ar': 'ملخص القرض',
    },
    'upfront_costs': {
      'en': 'Upfront Costs',
      'ar': 'التكاليف المبدئية',
    },
    'regulatory_information': {
      'en': 'Regulatory Information',
      'ar': 'معلومات تنظيمية'
    },
    'see_more': {
      'en': 'See More',
      'ar': 'عرض المزيد',
    },
    'view_details_on_rega': {
      'en': 'View details on REGA',
      'ar': 'عرض التفاصيل حول معلومات التنظيمية',
    },
    'choose_city': <String, String>{
      'en': 'Choose City',
      'ar': 'اختر المدينة',
    },
    'choose_community': <String, String>{
      'en': 'Choose Community',
      'ar': 'اختر المنطقة',
    },
    'choose_sub_community': <String, String>{
      'en': 'Choose Sub Community',
      'ar': 'اختر الحي',
    },
    'filter': <String, String>{
      'en': 'Filter',
      'ar': 'تصفية',
    },
    'type_of_property_looking_for': <String, String>{
      'en': 'Type of property looking for',
      'ar': 'نوع العقار الذي تبحث عنه',
    },
    'categories': <String, String>{
      'en': 'Categories',
      'ar': 'الفئات',
    },
    'price_range': <String, String>{
      'en': 'Price Range',
      'ar': 'نطاق السعر',
    },
    'area_range': <String, String>{
      'en': 'Area Range',
      'ar': 'نطاق المساحة',
    },
    'min_price': <String, String>{
      'en': 'Min Price',
      'ar': 'الحد الأدنى للسعر',
    },
    'max_price': <String, String>{
      'en': 'Max Price',
      'ar': 'الحد الأقصى للسعر',
    },
    'min_area': <String, String>{
      'en': 'Min Area',
      'ar': 'الحد الأدنى للمساحة',
    },
    'max_area': <String, String>{
      'en': 'Max Area',
      'ar': 'الحد الأقصى للمساحة',
    },
    'range': <String, String>{
      'en': 'Range',
      'ar': 'النطاق',
    },
    'bathrooms': <String, String>{
      'en': 'Bathrooms',
      'ar': 'الحمامات',
    },
    'location': {'en': 'Location', 'ar': 'الموقع'},
    'property_specification': {
      'en': 'Property Specification',
      'ar': 'مواصفات العقار'
    },
    'contact_us_for_more_details': {
      'en': 'Contact us for more details',
      'ar': 'اتصل بنا للحصول على مزيد من التفاصيل',
    },
    'book_now': {
      'en': 'Book Now',
      'ar': 'احجز الآن',
    },
    'report_this_unit': {
      'en': 'Report this unit',
      'ar': 'الإبلاغ عن هذه الوحدة',
    },
    'report_this_property': {
      'en': 'Report this property',
      'ar': 'الإبلاغ عن هذه الوحدة',
    },
    'report_reason': {
      'en': 'Report Reason',
      'ar': 'سبب الإبلاغ',
    },
    'select_the_reason': {
      'en': 'Select the Reason',
      'ar': 'اختر السبب',
    },
    'user_type': {
      'en': 'User Type',
      'ar': 'نوع المستخدم',
    },
    'select_the_type': {
      'en': 'Select the Type',
      'ar': 'اختر النوع',
    },
    'other_comments': {
      'en': 'Other Comments',
      'ar': 'تعليقات أخرى',
    },
    'add_your_additional_comments': {
      'en': 'Add your additional comments',
      'ar': 'أضف تعليقاتك الإضافية'
    },
    'send_report': {
      'en': 'Send Report',
      'ar': 'إرسال التقرير',
    },
    'property_info': {
      'en': 'Property Info',
      'ar': 'معلومات العقار',
    },
    'project_info': {
      'en': 'Project Info',
      'ar': 'معلومات المشروع',
    },
    'services': {
      'en': 'Services',
      'ar': 'الخدمات',
    },
    'show_all_services': {
      'en': 'Show All Services',
      ',ar': 'عرض جميع الخدمات',
    },
    'video_and_brochure': {
      'en': 'Video and Brochure',
      'ar': 'الفيديو والكتيب',
    },
    'video': {
      'en': 'Video',
      'ar': 'فيديو',
    },
    'brochure': {
      'en': 'Brochure',
      'ar': 'كتيب',
    },
    'view_brochure': {
      'en': 'View Brochure',
      'ar': 'عرض الكتيب',
    },
    'view_property_on_map': {
      'en': 'View Property on Map',
      'ar': 'عرض العقار على الخريطة',
    },
    'location_nearby_places': {
      'en': 'Location & Nearby Places',
      'ar': 'الموقع والأماكن القريبة',
    },
    'view_project_on_map': {
      'en': 'View Project on Map',
      'ar': 'عرض المشروع على الخريطة',
    },
    'nearby_places': {
      'en': 'Nearby Places',
      'ar': 'الأماكن القريبة',
    },
    'project_brochure': {
      'en': 'Project Brochure',
      'ar': 'كتيب المشروع',
    },
    'property_brochure': {
      'en': 'Property Brochure',
      'ar': 'كتيب العقار',
    },
    'read_more': {
      'en': 'Read More',
      'ar': 'قراءة المزيد',
    },
    'project_description': {
      'en': 'Project Description',
      'ar': 'وصف المشروع',
    },
    'installments': {
      'en': 'Installments',
      'ar': 'الأقساط',
    },
    'amount': {
      'en': 'Amount',
      'ar': 'المبلغ',
    },
    'payment_plans': {
      'en': 'Payment Plans',
      'ar': 'خطط الدفع',
    },
    'see_less': {
      'en': 'See Less',
      'ar': 'عرض أقل',
    },
    'view_units': {
      'en': 'View Units',
      'ar': 'عرض الوحدات',
    },
    'following': {
      'en': 'Following',
      'ar': 'المتابعة',
    },
    'price_with_tax': {
      'ar': 'السعر شامل الضريبة',
      'en': 'Price with TAX',
    },
    'financial_details': {
      'ar': 'التفاصيل المالية',
      'en': 'Financial details',
    },
    'general_details': {
      'ar': 'التفاصيل العامة',
      'en': 'General details',
    },
    'payment': {
      'en': 'Payment',
      'ar': 'الدفع',
    },
    'choose_your_payment_option': {
      'en': 'Choose Your Payment Option',
      'ar': 'اختر خيار الدفع الخاص بك',
    },
    'if_you_have_any_questions': {
      'en': 'If you have any questions',
      'ar': 'إذا كان لديك أي أسئلة',
    },
    'online_booking_available': {
      'en':
          'Online booking is for Saudi residents only. Please contact our team to complete the manual booking process',
      'ar':
          'الحجز الإلكتروني متاح للمقيمين في السعودية فقط. يرجى التواصل مع فريقنا لإكمال إجراء الحجز',
    },
    'confirm_your_data': {
      'en': 'Confirm Your Data',
      'ar': 'تأكيد بياناتك',
    },
    'transfer_to_nafath': {
      'en':
          'You will be transferred to NAFATH\nVerify your information before completing the order',
      'ar': 'سيتم تحويلك الى منصة نفاذ تأكد من معلومات قبل اتمام الطلب',
    },
    'commission_vat': {
      'en': 'Commission Amount & VAT',
      'ar': 'السعي والضريبة المضافة',
    },
    'choose_payment_method': {
      'en': 'Choose your payment method',
      'ar': 'اختر طريقة الدفع',
    },
    'share_payment_link': {
      'en': 'Share Payment Link',
      'ar': 'مشاركة رابط الدفع',
    },
    'upload_receipt': {
      'en': 'Upload Receipt',
      'ar': 'مشاركة رابط الدفع',
    },
    'customer_details': {
      'en': 'Customer Details',
      'ar': 'تفاصيل العميل',
    },
    'customer_name': {
      'en': 'Customer Name',
      'ar': 'اسم العميل',
    },
    'mobile_number': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف',
    },
    'address': {
      'en': 'Address',
      'ar': 'العنوان',
    },
    'required_field': {
      'en': 'Required Field',
      'ar': 'حقل مطلوب',
    },
    'please_select_payment_option': {
      'en': 'Please select payment option',
      'ar': 'الرجاء تحديد خيار الدفع',
    },
    'payment_status': {
      'en': 'Payment Status',
      'ar': 'حالة الدفع',
    },
    'failed_payment_msg': {
      'en': 'Something went wrong, please try again later',
      'ar': 'حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا',
    },
    'wrong': {
      'en': 'Wrong',
      'ar': 'خطأ',
    },
    'success_payment_msg': {
      'en': 'Your payment was successful',
      'ar': 'تم الدفع بنجاح',
    },
    'success': {
      'en': 'Success',
      'ar': 'نجاح',
    },
    'unit_layout': {
      'en': 'Unit Layout',
      'ar': 'مخطط الوحدة',
    },
    'view_unit_layout': {
      'en': 'View unit design layout',
      'ar': 'عرض مخطط تصميم الوحدة',
    },
    'click_to_show_details': {
      'en': 'Click to show  details',
      'ar': 'اضغط لإظهار التفاصيل',
    },
    'layout_of_unit_no': {
      'en': 'Layout of unit no.',
      'ar': 'تخطيط الوحدة رقم',
    },
    'live_location_on_map': {
      'en': 'Live location on map',
      'ar': 'الموقع المباشر على الخريطة',
    },
    'please_continue_selection': {
      'en': 'Please continue selection',
      'ar': 'يرجى متابعة الاختيار',
    },
    'available_units': {
      'en': 'Available Units',
      'ar': 'الوحدات المتاحة',
    },
    'please_select_the_sorting': {
      'en': 'Please select the sorting according to the following',
      'ar': 'يرجى تحديد الترتيب وفقًا لما يلي',
    },
    'newest': {
      'en': 'Newest',
      'ar': 'الأحدث',
    },
    'apply': {
      'en': 'Apply',
      'ar': 'تطبيق',
    },
    'project_units': {
      'en': 'Project Units',
      'ar': 'وحدات المشروع',
    },
    'low_to_high': {
      'en': 'Low to High',
      'ar': 'من الأقل إلى الأعلى',
    },
    'high_to_low': {
      'en': 'High to Low',
      'ar': 'من الأعلى إلى الأقل',
    },
    'starting_price': {
      'en': 'Starting Price',
      'ar': 'السعر الابتدائي',
    },
    'oldest_to_newest': {
      'en': 'Oldest to Newest',
      'ar': 'الأقدم إلى الأحدث',
    },
    'newest_to_oldest': {
      'en': 'Newest to Oldest',
      'ar': 'الأحدث إلى الأقدم',
    },
    'floors': {
      'en': 'Floors',
      'ar': 'الأرضيات',
    },
  },
].reduce((Map<String, Map<String, String>> a,
            Map<String, Map<String, String>> b) =>
        a..addAll(b));
