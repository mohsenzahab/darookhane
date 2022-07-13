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

  late String userName;
  late String password;

  bool signingIn = false;

  void signIn() async {
    debugPrint('sign in pressd');
    {}
    DB.db.setPatientData(Patient(
        name: 'test',
        gender: Gender.male,
        userName: '1231',
        birthDate: Jalali.now(),
        id: 12));
    debugPrint('data saved');
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      updateSignInBtn(true);
      final result = await API.api.login(userName, password);
      updateSignInBtn(false);

      if (result.isOk) {
        DB.db.setPatientToken(result.token);

        API.api
            .getPatientData(result.token)
            .then((data) => DB.db.setPatientData(data));

        Get.offAndToNamed(Routes.HOME);
      } else {
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
