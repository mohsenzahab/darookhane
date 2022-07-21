import 'dart:developer';

import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/data/models/reservation.dart';
import 'package:darookhane/app/data/models/specialty.dart';
import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/data/provider/locale_db.dart';
import 'package:darookhane/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class HomeController extends GetxController {
  bool _showDoctors = false;

  late final String token;
  Future<Map<Specialty, List<Doctor>>>? specialties;
  Specialty? selectedSpecialty;
  DateTime selectedDate = DateTime.now();
  String? searchedDoctorName;

  void searchDoctor(String? name) {
    searchedDoctorName = name?.trim();
    if ((searchedDoctorName?.length ?? 0) > 0) {
      update(['1']);
    }
  }

  void toProfilePage() {
    Get.toNamed(Routes.PROFILE);
  }

  @override
  Future<void> onInit() async {
    token = (await DB.db.getLoggedInUserToken())!;
    specialties = API.api.getDoctorsPerSpecialty(token).then((value) {
      update(['data']);
      return value;
    });
    super.onInit();
  }

  set showDoctors(bool newVal) => {
        _showDoctors = newVal,
        update(['1'])
      };
  bool get showDoctors => _showDoctors;

  void searchDoctors() {
    showDoctors = true;
  }

  void specialtyChanged(Specialty? specialty) {
    selectedSpecialty = specialty;
  }

  void dateChanged(DateTime? date) {}

  Future<bool> reserve(Doctor doctor) async {
    final response = await API.api.createReservation(
        token,
        Reservation(
          date: Jalali.fromDateTime(selectedDate),
          doctor: doctor,
        ));
    log(response.message ?? 'response');
    if (response.isOk) {
      Get.showSnackbar(GetSnackBar(
        title: 'رزرو با موفقیت انجام شد',
        message: 'دکتر ${doctor.name} تخصص: ${doctor.specialty.name}',
        duration: Duration(seconds: 5),
      ));
      return true;
    } else {
      return false;
    }
  }

  void toReservations() {
    Get.toNamed(Routes.RESERVATIONS);
  }
}
