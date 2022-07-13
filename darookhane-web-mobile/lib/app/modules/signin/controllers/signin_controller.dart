import 'dart:developer';

import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/data/provider/locale_db.dart';
import 'package:darookhane/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String userName = '292123456';
  late String password = '123456';

  bool signingIn = false;

  void signIn() async {
    debugPrint('sign in pressd');
    {}
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      updateSignInBtn(true);
      final result = await API.api.login(userName, password);

      if (result.isOk) {
        DB.db.setPatientToken(result.token);

        Patient patient = await API.api.getPatientData(result.token);
        patient.password = password;
        DB.db.setPatientData(patient);
        patient = (await DB.db.patientData)!;
        log('patient data: ${(patient).toJson()}');
        updateSignInBtn(false);

        Get.offAndToNamed(Routes.HOME);
      } else {
        updateSignInBtn(false);

        Get.showSnackbar(GetSnackBar(
          title: 'Sing Up error:${result.reason}',
          message: result.message,
        ));
      }
    }
  }

  void signUpView() {
    Get.offAndToNamed(Routes.SIGNUP);
  }

  void updateSignInBtn(bool signingIn) {
    this.signingIn = signingIn;
    update(['signin']);
  }
}
