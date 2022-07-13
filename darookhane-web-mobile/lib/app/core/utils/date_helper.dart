import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DateHelper on Jalali {
  String get toData {
    JalaliFormatter f = formatter;

    return '${f.yyyy}-${f.mm}-${f.dd}';
  }

  static String format(BuildContext context, DateTime date) {
    final f = Jalali.fromDateTime(date).formatter;
    final m = MaterialLocalizations.of(context);
    return '${f.wN} ${m.formatDecimal(f.date.day)} ${f.mN} ${m.formatDecimal(f.date.year)}';
  }

  static Jalali parse(String date) {
    List<String> ymd = date.split('-');
    return Jalali(int.parse(ymd[0]), int.parse(ymd[1]), int.parse(ymd[2]));
  }
}
