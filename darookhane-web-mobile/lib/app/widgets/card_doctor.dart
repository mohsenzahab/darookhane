import 'dart:io';

import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDoctor extends StatelessWidget {
  const CardDoctor({Key? key, required this.doctor}) : super(key: key);

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    final Widget name, specialty, leftTurns, button;

    name = Text(doctor.name);
    specialty =
        Text('${LocaleKeys.text_title_label_specialty.tr}:${doctor.specialty}');
    leftTurns =
        Text('${LocaleKeys.text_title_label_number_of_turns_left.tr}:2');
    button = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.greenAccent)),
        onPressed: () {},
        child: Text(LocaleKeys.button_reserve.tr));
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: kFilledColor, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: isDesktop
            ? Wrap(
                spacing: 20,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
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