import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/widgets/gender_selector.dart';
import 'package:darookhane/app/widgets/text_field.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetResponsiveView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    Widget widget = Form(
      key: controller.formKey,
      child: GetBuilder<ProfileController>(
          id: 'patient',
          builder: (c) {
            if (c.patient != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  kSpaceVertical16,
                  MTextField(
                    initialValue: c.patient!.name,
                    labelText: LocaleKeys.text_field_full_name.tr,
                    onSaved: (s) => c.patient!.name = s!,
                  ),
                  kSpaceVertical16,
                  MTextField(
                    initialValue: c.patient!.password,
                    labelText: LocaleKeys.text_field_password.tr,
                    onSaved: (s) => c.patient!.password = s!,
                  ),
                  kSpaceVertical16,
                  MTextField(
                    labelText: LocaleKeys.text_field_phon_number.tr,
                    // onSaved: (s) => controller.phoneNumber = s!,
                    inputType: TextInputType.phone,
                  ),
                  kSpaceVertical16,
                  kSpaceVertical16,
                  GenderSelectorForm(
                      value: c.patient!.gender,
                      onChanged: ((newGender) =>
                          c.patient!.gender = newGender!)),
                  kSpaceVertical32,
                  ElevatedButton(
                      onPressed: controller.onSubmitButtonPressed,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                      child: GetBuilder<ProfileController>(
                        id: 'save',
                        builder: (c) {
                          return c.isSaving
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text('ثبت');
                        },
                      )),
                  TextButton(
                    onPressed: () => c.logOut(),
                    child: Text('خروج از حساب',
                        style: TextStyle(color: Colors.red)),
                  )
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          }),
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
      appBar: AppBar(),
      body: SafeArea(child: widget),
    );
  }
}
