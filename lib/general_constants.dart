import 'general_exports.dart';

const String testImage =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbKmfvWO4JWUjAEY4Qk8oJnCvyiMA4mejjbA&s';

bool isRTL = false;

void setIsRTL(BuildContext context) => isRTL = Directionality.of(context)
    .toString()
    .contains(TextDirection.rtl.name.toLowerCase());
