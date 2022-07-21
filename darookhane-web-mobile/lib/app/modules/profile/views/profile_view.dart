import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/widgets/form_container.dart';
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
              return Theme(
                data: Theme.of(Get.context!).copyWith(
                    inputDecorationTheme: Theme.of(Get.context!)
                        .inputDecorationTheme
                        .copyWith(fillColor: kColorFill)),
                child: Column(
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
                ),
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
      padding: EdgeInsets.all(10),
      child: FormContainer(child: widget),
    );
    if (screen.isDesktop || screen.isTablet) {
      widget = SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: widget);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('اطلاعات بیمار', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(child: widget),
    );
  }
}
