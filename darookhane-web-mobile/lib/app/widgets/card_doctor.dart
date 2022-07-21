import 'dart:io';

import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/modules/home/controllers/home_controller.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDoctor extends StatelessWidget {
  const CardDoctor({Key? key, required this.doctor}) : super(key: key);

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    final Widget name, specialty, leftTurns, button;

    name = Text(
      doctor.name,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
    specialty = RichText(
      text: TextSpan(
          text: '${LocaleKeys.text_title_label_specialty.tr}: ',
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
          children: [
            TextSpan(
                text: doctor.specialty.name,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 17))
          ]),
    );
    leftTurns = Text(
      '${LocaleKeys.text_title_label_number_of_turns_left.tr}:2',
      style: const TextStyle(
          color: kColorPrimary, fontSize: 12, fontWeight: FontWeight.w400),
    );
    button = SizedBox(
      height: 28,
      width: 90,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7))),
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(kColorReserveButton)),
          onPressed: () {
            Get.find<HomeController>().reserve(doctor);
          },
          child: Text(
            LocaleKeys.button_reserve.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          )),
    );
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: kColorDoctorCard, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: isDesktop
            ? Wrap(
                spacing: 20,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [name, specialty, leftTurns, button],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [name, kSpaceHorizontal16, button],
                  ),
                  kSpaceVertical10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [specialty, kSpaceHorizontal16, leftTurns],
                  )
                ],
              ),
      ),
    );
  }
}
