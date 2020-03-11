import 'package:intl/intl.dart';

class Util {

  static String formatDate(date) {
    var dateParsed = DateTime.parse(date);
    final DateFormat dateFormat = DateFormat("EEEE, MMM. d");

    return dateFormat.format(dateParsed).toString();
  }

  static String formatTimestamp(date) {
    var timestampParsed = DateTime.parse(date);
    final DateFormat timestampFormat = DateFormat("jm");

    return timestampFormat.format(timestampParsed).toString();
  }

  static String formatDateWithYear(date) {
    var dateParsed = DateTime.parse(date);
    final DateFormat dateFormat = DateFormat("EEEE, MMM. d yyyy");
    return dateFormat.format(dateParsed).toString();
  }
}