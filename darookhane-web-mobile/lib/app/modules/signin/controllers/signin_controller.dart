import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

  late String userName;
  late String password;
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

  void signIn() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      API.instance.login(userName, password);
    }
  }

  void signUpView() {
    Get.back();
    Get.toNamed(Routes.SIGNUP);
  }
}
