import 'package:intl/intl.dart';
String dateFormatted() {
  var now = DateTime.now();
  var formatter = new DateFormat("EEE, d MMM, yyyy");
  String formatted = formatter.format(now);

  return formatted;
}