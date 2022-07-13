import 'dart:convert';

import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String fullName;
  late String userName;
  late String password;
  late String phoneNumber;
  late Gender gender;

  bool signingUp = false;

  void onSubmitButtonPressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      updateSignUpButton(true);
      Patient patient = Patient(
          userName: userName,
          gender: gender,
          name: fullName,
          // password: password,
          birthDate: Jalali.now());

      final result = await API.api.register(patient);
      debugPrint(patient.toJson());
      updateSignUpButton(false);
      if (result.isOk) {
        Get.snackbar('Sing Up', 'Sign Up successful',
            duration: const Duration(seconds: 5));
        // DB.db.setPatientData(patient);
        Get.offAndToNamed(Routes.SIGNIN);
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Sing Up error:${result.reason}',
          message: result.message,
          duration: const Duration(seconds: 5),
        ));
      }
    }
  }

  void updateSignUpButton(bool signingUp) {
    this.signingUp = signingUp;
    update(['signup']);
  }

  void toSignInView() {
    Get.offAndToNamed(Routes.SIGNIN);
  }
}
