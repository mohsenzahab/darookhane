import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class SignupController extends GetxController {
  final GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

  late String fullName;
  late String userName;
  late String password;
  late String phoneNumber;
  late Gender gender;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSubmitButtonPressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Patient patient = Patient(
          userName: userName,
          gender: gender,
          name: fullName,
          password: password,
          birthDate: Jalali.now());

      final result = await API.instance.register(patient);
      if (result[API.result]) {
        Get.snackbar('Signup', 'Signup successful');
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Singup',
          message: result[API.message],
        ));
      }
    }
    Get.back();
    Get.toNamed(Routes.SIGNIN);
  }

  void toSignInView() {
    Get.back();
    Get.toNamed(Routes.SIGNIN);
  }
}
