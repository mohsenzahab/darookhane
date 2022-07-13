import 'package:flutter/material.dart';
import 'package:jalali_date_picker/src/enums/calendar_mode.dart';
import 'package:shamsi_date/shamsi_date.dart';

class JalaliDateUtils {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  JalaliDateUtils._();

  /// Returns a [DateTime] with the date of the original, but time set to
  /// midnight.
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Returns a [DateTimeRange] with the dates of the original, but with times
  /// set to midnight.
  ///
  /// See also:
  ///  * [dateOnly], which does the same thing for a single date.
  static DateTimeRange datesOnly(DateTimeRange range) {
    return DateTimeRange(
        start: dateOnly(range.start), end: dateOnly(range.end));
  }

  /// Returns true if the two [DateTime] objects have the same day, month, and
  /// year, or are both null.
  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }

  /// Returns true if the two [DateTime] objects have the same month and
  /// year, or are both null.
  static bool isSameMonth(
      DateTime? dateA, DateTime? dateB, CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return dateA?.year == dateB?.year && dateA?.month == dateB?.month;
    } else {
      Jalali? a;
      if (dateA != null) a = Jalali.fromDateTime(dateA);
      Jalali? b;
      if (dateB != null) b = Jalali.fromDateTime(dateB);
      return a?.year == b?.year && a?.month == b?.month;
    }
  }

  /// Determines the number of months between two [DateTime] objects.
  ///
  /// For example:
  /// ```
  /// DateTime date1 = DateTime(year: 2019, month: 6, day: 15);
  /// DateTime date2 = DateTime(year: 2020, month: 1, day: 15);
  /// int delta = monthDelta(date1, date2);
  /// ```
  ///
  /// The value for `delta` would be `7`.
  static int monthDelta(
      DateTime startDate, DateTime endDate, CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return (endDate.year - startDate.year) * 12 +
            endDate.month -
            startDate.month;
      case CalendarMode.jalali:
        Jalali s = Jalali.fromDateTime(startDate);
        Jalali e = Jalali.fromDateTime(endDate);
        return (e.year - s.year) * 12 + e.month - s.month;
    }
  }

  /// Returns a [DateTime] that is [monthDate] with the added number
  /// of months and the day set to 1 and time set to midnight.
  ///
  /// For example:
  /// ```
  /// DateTime date = DateTime(year: 2019, month: 1, day: 15);
  /// DateTime futureDate = DateUtils.addMonthsToMonthDate(date, 3);
  /// ```
  ///
  /// `date` would be January 15, 2019.
  /// `futureDate` would be April 1, 2019 since it adds 3 months.
  static DateTime addMonthsToMonthDate(
      DateTime monthDate, int monthsToAdd, CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return DateTime(monthDate.year, monthDate.month + monthsToAdd);
      case CalendarMode.jalali:
        return Jalali.fromDateTime(monthDate)
            .addMonths(monthsToAdd)
            .toDateTime();
    }
  }

  /// Returns a [DateTime] with the added number of days and time set to
  /// midnight.
  static DateTime addDaysToDate(
      DateTime date, int days, CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return DateTime(date.year, date.month, date.day + days);
      case CalendarMode.jalali:
        return Jalali.fromDateTime(date).addDays(days).toDateTime();
    }
  }

  /// Computes the offset from the first day of the week that the first day of
  /// the [month] falls on.
  ///
  /// For example, September 1, 2017 falls on a Friday, which in the calendar
  /// localized for United States English appears as:
  ///
  /// ```
  /// S M T W T F S
  /// _ _ _ _ _ 1 2
  /// ```
  ///
  /// The offset for the first day of the months is the number of leading blanks
  /// in the calendar, i.e. 5.
  ///
  /// The same date localized for the Russian calendar has a different offset,
  /// because the first day of week is Monday rather than Sunday:
  ///
  /// ```
  /// M T W T F S S
  /// _ _ _ _ 1 2 3
  /// ```
  ///
  /// So the offset is 4, rather than 5.
  ///
  /// This code consolidates the following:
  ///
  /// - [DateTime.weekday] provides a 1-based index into days of week, with 1
  ///   falling on Monday.
  /// - [MaterialLocalizations.firstDayOfWeekIndex] provides a 0-based index
  ///   into the [MaterialLocalizations.narrowWeekdays] list.
  /// - [MaterialLocalizations.narrowWeekdays] list provides localized names of
  ///   days of week, always starting with Sunday and ending with Saturday.
  static int firstDayOffset(DateTime date, CalendarMode calendarMode,
      MaterialLocalizations localizations) {
    // 0-based day of week for the month and year, with 0 representing Monday.
    final int weekdayFromMonday = date.monthStartDate(calendarMode).weekday - 1;
    // 0-based start of week depending on the locale, with 0 representing Sunday.
    int firstDayOfWeekIndex = firstDayOfWeek(calendarMode);

    // firstDayOfWeekIndex recomputed to be Monday-based, in order to compare with
    // weekdayFromMonday.
    firstDayOfWeekIndex = (firstDayOfWeekIndex - 1) % 7;

    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the first of the month.
    return (weekdayFromMonday - firstDayOfWeekIndex) % 7;
  }

  static int firstDayOfWeek(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return 0;
      case CalendarMode.jalali:
        return 6;
    }
  }

  /// Returns the number of days in a month, according to the proleptic
  /// Gregorian calendar.
  ///
  /// This applies the leap year logic introduced by the Gregorian reforms of
  /// 1582. It will not give valid results for dates prior to that time.
  static int getDaysInMonth(DateTime date, CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        if (date.month == DateTime.february) {
          final bool isLeapYear =
              (date.year % 4 == 0) && (date.year % 100 != 0) ||
                  (date.year % 400 == 0);
          return isLeapYear ? 29 : 28;
        }
        const List<int> daysInMonth = <int>[
          31,
          -1,
          31,
          30,
          31,
          30,
          31,
          31,
          30,
          31,
          30,
          31
        ];
        return daysInMonth[date.month - 1];
      case CalendarMode.jalali:
        return Jalali.fromDateTime(date).monthLength;
    }
  }

  static const List<String> _jalaliMonthNames = [
    'Farvardin',
    'Ordibehesh',
    'Khordad',
    'Tir',
    'Mordad',
    'Shahrivar',
    'Mehr',
    'Aban',
    'Azar',
    'Dey',
    'Bahman',
    'Esfand'
  ];

  static const List<String> _weekDayNamesEn = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static String formatMonthYear(DateTime date, Locale locale,
      MaterialLocalizations localizations, CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return localizations.formatMonthYear(date);
      case CalendarMode.jalali:
        Jalali d = Jalali.fromDateTime(date);
        switch (locale.languageCode) {
          case 'fa':
            var f = d.formatter;
            return '${f.yyyy} ${f.mN}'.fromEnTo(locale);
          case 'en':
            return '${_jalaliMonthNames[d.month - 1]} ${d.year}';
        }
    }
    return '';
  }

  static String formatMediumDate(DateTime date, Locale locale,
      MaterialLocalizations localizations, CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return localizations.formatMediumDate(date);
      case CalendarMode.jalali:
        Jalali d = Jalali.fromDateTime(date);
        switch (locale.languageCode) {
          case 'fa':
            var f = d.formatter;
            return '${f.wN}، ${f.m.fromEnTo(locale)} ${f.d}';
          case 'en':
            return '${_weekDayNamesEn[date.weekday % 7]}, ${_jalaliMonthNames[d.month - 1]} ${d.day}';
        }
    }
    return '';
  }
}

extension DateHelperExtension on DateTime {
  Jalali get jalaliDate => Jalali.fromDateTime(this);

  // String format(CalendarMode calendarMode, Locale locale) {
  //   if (calendarMode == CalendarMode.gregorian) {
  //     return DateFormat('MM/dd/yyyy').format(this);
  //   } else {
  //     var f = Jalali.fromDateTime(this).formatter;
  //     return '${f.yyyy}/${f.mm}/${f.dd}';
  //   }
  // }

  // String dayOfMonth(CalendarMode calendarMode, Locale locale) {
  //   if (calendarMode == CalendarMode.gregorian) {
  //     return DateFormat('MM/dd').format(this);
  //   } else {
  //     var f = Jalali.fromDateTime(this).formatter;
  //     return '${f.mm}/${f.dd}';
  //   }
  // }

  String dayOfWeek(Locale locale) {
    if (locale.languageCode == 'en') {
      return dayOfWeek(locale);
    } else {
      return Jalali.fromDateTime(this).formatter.wN;
    }
  }

  String toData() {
    return toString().split(' ')[0];
  }

  bool isInSameWeekWith(DateTime other, CalendarMode calendarMode) {
    return weekStartDate(calendarMode)
        .isSameDate(other.weekStartDate(calendarMode));
  }

  DateTime weekStartDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.jalali) {
      int weekday = this.weekday;
      if (weekday >= 6) {
        weekday = weekday - 5;
      } else {
        weekday = weekday + 2;
      }
      DateTime date = subtract(Duration(days: weekday - 1).abs());
      return DateTime(date.year, date.month, date.day);
    } else {
      DateTime date = subtract(Duration(days: weekday - 1));
      return DateTime(date.year, date.month, date.day);
    }
  }

  DateTime weekEndDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.jalali) {
      int weekday = this.weekday;
      if (weekday >= 6) {
        weekday = weekday - 5;
      } else {
        weekday = weekday + 2;
      }
      DateTime date = subtract(Duration(days: weekday - 1).abs());
      return DateTime(date.year, date.month, date.day + 6);
    } else {
      DateTime date = subtract(Duration(days: weekday - 1));
      return DateTime(date.year, date.month, date.day + 6);
    }
  }

  DateTime monthStartDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, month, 1);
    } else {
      return Jalali.fromDateTime(this).copy(day: 1).toDateTime();
    }
  }

  DateTime monthEndDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
    } else {
      Jalali jalaliMonthStart =
          Jalali.fromDateTime(this).copy(day: 1).addMonths(1).addDays(-1);
      return jalaliMonthStart.toDateTime();
    }
  }

  DateTime yearStartDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, 1, 1);
    } else {
      return Jalali.fromDateTime(this).copy(month: 1, day: 1).toDateTime();
    }
  }

  DateTime yearEndDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year + 1, 1, 1).subtract(const Duration(days: 1));
    } else {
      return Jalali.fromDateTime(this)
          .copy(month: 1, day: 1)
          .addYears(1)
          .addDays(-1)
          .toDateTime();
    }
  }

  int dateDifference(DateTime secondDate) {
    return dateOnly.difference(secondDate.dateOnly).inDays;
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isInRange(DateTime startDate, DateTime endDate) {
    return (isAfter(startDate) || isSameDate(startDate)) &&
        (isBefore(endDate) || isSameDate(endDate));
  }

  DateTime get dateOnly => DateTime(year, month, day);

  // String getGregorianWeekDayAndDate() {
  //   final f = DateFormat('EEEE, MMM d');
  //   return f.format(this);
  // }

  DateTime addMonth(int count, CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, month + count, day, hour, minute, second);
    } else {
      return Jalali.fromDateTime(this).addMonths(count).toDateTime();
    }
  }

  DateTime addYears(int count, CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year + 1, month, day);
    } else {
      return Jalali.fromDateTime(this).addYears(1).toDateTime();
    }
  }

  String getJalaliDay() {
    final f = Jalali.fromDateTime(this).formatter;

    return f.d;
  }

  // String getWeekDayAndDate(CalendarMode calendarMode, Locale locale) {
  //   if (calendarMode == CalendarMode.gregorian)
  //     return DateFormat('MMMEd', locale.toString()).format(this);
  //
  //   //TODO: if calendar mode is jalali, we must translate fa to other languages.
  //   switch (locale.languageCode) {
  //     default:
  //       //persian
  //       final f = Jalali.fromDateTime(this).formatter;
  //       return '${f.wN}، ${f.d} ${f.mN}';
  //   }
  // }

  String getJalaliWeekDayAndDate() {
    final f = Jalali.fromDateTime(this).formatter;

    return '${f.wN}، ${f.d} ${f.mN}';
  }

// String getMonthName(CalendarMode calendarMode, String language) {
//   if (calendarMode == CalendarMode.gregorian)
//     return DateFormat('MMM', language).format(this);
//   else {
//     if (language == 'fa')
//       return '${Jalali.fromDateTime(this).formatter.mN}';
//     else {
//       int monthNumber = Jalali.fromDateTime(this).month;
//       return [
//         'Farvardin',
//         'Ordibehesh',
//         'Khordad',
//         'Tir',
//         'Mordad',
//         'Shahrivar',
//         'Mehr',
//         'Aban',
//         'Azar',
//         'Dey',
//         'Bahman',
//         'Esfand'
//       ][monthNumber - 1];
//     }
//   }
// }
}

extension StringExtensions on String {
  String fromEnTo(Locale language) {
    String number = this;
    var persianNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

    if (language.languageCode == 'fa') {
      for (var i = 0; i < 10; i++) {
        number = number.replaceAll(RegExp(enNumbers[i]), persianNumbers[i]);
      }
    } else if (language.languageCode == 'en') {
      return this;
    } else {
      for (var i = 0; i < 10; i++) {
        number = number.replaceAll(RegExp(enNumbers[i]), arabicNumbers[i]);
      }
    }

    return number;
  }
}
