import 'package:shamsi_date/shamsi_date.dart';

extension DateHelper on Jalali {
  String get toData {
    JalaliFormatter f = formatter;

    return '${f.yyyy}-${f.mm}-${f.dd}';
  }

  static Jalali parse(String date) {
    List<String> ymd = date.split('-');
    return Jalali(int.parse(ymd[0]), int.parse(ymd[1]), int.parse(ymd[2]));
  }
}
