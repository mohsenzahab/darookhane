import 'package:darookhane/app/data/models/reservation.dart';
import 'package:darookhane/app/data/provider/api.dart';
import 'package:darookhane/app/data/provider/locale_db.dart';
import 'package:get/get.dart';

class ReservationsController extends GetxController {
  RxList<Reservation> reservations = <Reservation>[].obs;

  final count = 0.obs;
  var token = ''.obs;
  @override
  void onInit() async {
    DB.db.getLoggedInUserToken().then((t) async {
      token.value = t!;
      reservations.value =
          (await API.api.getPatientReservations(token.value, false)).obs;
    });
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

  void increment() => count.value++;

  cancelReservation(Reservation reservation) {}
}
