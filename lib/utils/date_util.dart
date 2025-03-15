import 'package:intl/intl.dart';

String isoToReadableDate(String isoFormat) {
  final DateTime dateTime = DateTime.parse(isoFormat);
  final DateFormat formatter = DateFormat('d MMM, yyyy');
  return formatter.format(dateTime);
}
