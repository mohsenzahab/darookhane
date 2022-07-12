import 'package:get/get.dart';

import '../controllers/doctors_list_controller.dart';

class DoctorsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsListController>(
      () => DoctorsListController(),
    );
  }
}
