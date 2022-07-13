import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/widgets/text_field.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetResponsiveView<SigninController> {
  SigninView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    Widget widget = Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTextField(
            initialValue: controller.userName,
            labelText: LocaleKeys.text_field_user_name.tr,
            onSaved: (s) => controller.userName = s!,
          ),
          kSpaceVertical16,
          MTextField(
            initialValue: controller.password,
            labelText: LocaleKeys.text_field_password.tr,
            onSaved: (s) => controller.password = s!,
          ),
          kSpaceVertical16,
          kSpaceVertical32,
          ElevatedButton(
              onPressed: controller.signIn,
              child: GetBuilder<SigninController>(
                id: 'signin',
                builder: (c) {
                  return c.signingIn
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(LocaleKeys.button_login.tr);
                },
              )),
          TextButton(
              onPressed: controller.signUpView, child: Text('حساب ندارید؟'))
        ],
      ),
    );
    if (screen.isDesktop || screen.isTablet) {
      double width = screen.width > 1000
          ? (screen.width > 1500 ? 750 : screen.width / 2)
          : 500;
      widget = Container(
          width: 500,
          margin: kMarginForm,
          padding: kPaddingForm,
          decoration: kDecorationForm,
          child: widget);
    } else {
      if (screen.width > 2 * kMarginForm.left + kFormMinWidth) {
        widget = SizedBox(width: kFormMinWidth, child: widget);
      }

      widget = Center(
        child: Padding(
          padding: kMarginForm,
          child: widget,
        ),
      );
    }
    widget = SingleChildScrollView(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.text_title_user_login.tr),
          widget,
        ],
      ),
    );
    if (screen.isDesktop || screen.isTablet) {
      widget = SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: widget);
    }
    return Scaffold(
      body: SafeArea(child: widget),
    );
  }
}
