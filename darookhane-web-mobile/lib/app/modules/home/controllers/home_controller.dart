import 'package:get/get.dart';

class HomeController extends GetxController {
  bool _showDoctors = false;

  set showDoctors(bool newVal) => {
        _showDoctors = newVal,
        update(['1'])
      };
  bool get showDoctors => _showDoctors;
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
}
