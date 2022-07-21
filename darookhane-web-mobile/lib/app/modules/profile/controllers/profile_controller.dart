import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/data/provider/locale_db.dart';
import 'package:darookhane/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Patient? patient;

  @override
  void onInit() {
    DB.db.patientData.then((value) {
      patient = value!;
      update(['patient']);
    });
    super.onInit();
  }

  bool isSaving = false;

  void onSubmitButtonPressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      updateSignUpButton(true);
      String? token = await DB.db.getLoggedInUserToken();
      final result = await API.api.updatePatient(token!, patient!);
      debugPrint(patient!.toJson());
      if (result.isOk) {
        Get.showSnackbar(GetSnackBar(
            title: 'تغییرات ذخیره شد',
            message: 'تغییرات با موفقیت ذخیره شد.',
            duration: const Duration(seconds: 5)));
        DB.db.setPatientData(patient!);
        updateSignUpButton(false);
      } else {
        updateSignUpButton(false);

        Get.showSnackbar(GetSnackBar(
          title: 'Sing Up error:${result.reason}',
          message: result.message,
          duration: const Duration(seconds: 5),
        ));
      }
    }
  }

  void updateSignUpButton(bool signingUp) {
    isSaving = signingUp;
    update(['signup']);
  }

  void toSignInView() {
    Get.offAndToNamed(Routes.SIGNIN);
  }

  void logOut() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text('آیا می خواهید از حسابتان خارج شوید؟'),
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsAlignment: MainAxisAlignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      DB.db.clearLoginSession();
                      Get.offAllNamed(Routes.SIGNIN);
                    },
                    child: Text('خروج از حساب')),
                OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('لغو'))
              ],
            ),
          );
        });
  }
}
