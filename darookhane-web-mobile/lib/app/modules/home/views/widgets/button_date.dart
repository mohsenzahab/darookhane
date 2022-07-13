import 'package:darookhane/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalali_date_picker/jalali_date_picker.dart';
import 'package:darookhane/app/core/utils/date_helper.dart';

class ButtonDate extends StatefulWidget {
  const ButtonDate({Key? key, this.dateChanged}) : super(key: key);

  final void Function(DateTime? date)? dateChanged;

  @override
  State<ButtonDate> createState() => _ButtonDateState();
}

class _ButtonDateState extends State<ButtonDate> {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return ElevatedButton(
        onPressed: () {
          final date = c.selectedDate;
          showJalaliDatePicker(
                  calendarMode: CalendarMode.jalali,
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)))
              .then((value) {
            widget.dateChanged?.call(value);
            setState(() {
              c.selectedDate = value ?? DateTime.now();
            });
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            Text(
              c.selectedDate != null
                  ? DateHelper.format(context, c.selectedDate)
                  : 'انتخاب تاریخ',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}
