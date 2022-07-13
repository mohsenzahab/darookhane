import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/widgets/gender_selector.dart';
import 'package:darookhane/app/widgets/text_field.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetResponsiveView<SignupController> {
  SignupView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    Widget widget = Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTextField(
            inputType: TextInputType.number,
            hintText: LocaleKeys.text_field_user_name.tr,
            onSaved: (s) => controller.userName = s!,
          ),
          kSpaceVertical16,
          MTextField(
            hintText: LocaleKeys.text_field_full_name.tr,
            onSaved: (s) => controller.fullName = s!,
          ),
          kSpaceVertical16,
          MTextField(
            hintText: LocaleKeys.text_field_phon_number.tr,
            onSaved: (s) => controller.phoneNumber = s!,
            inputType: TextInputType.phone,
          ),
          kSpaceVertical16,
          MTextField(
            hintText: LocaleKeys.text_field_password.tr,
            onSaved: (s) => controller.password = s!,
          ),
          kSpaceVertical16,
          GenderSelectorForm(
              onChanged: ((newGender) => controller.gender = newGender!)),
          kSpaceVertical32,
          ElevatedButton(
              onPressed: controller.onSubmitButtonPressed,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
              child: GetBuilder<SignupController>(
                id: 'signup',
                builder: (c) {
                  return c.signingUp
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(LocaleKeys.button_register.tr);
                },
              )),
          TextButton(
              onPressed: controller.toSignInView,
              child: Text('از قبل ثبت نام کرده اید؟')),
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
      padding: EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.text_title_register_user.tr),
          widget,
        ],
      ),
    );
    if (screen.isDesktop || screen.isTablet) {
      widget = SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: widget);
    }
    return Scaffold(
      body: widget,
    );
  }
}
