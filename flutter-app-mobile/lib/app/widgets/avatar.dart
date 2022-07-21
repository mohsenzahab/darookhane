import 'package:darookhane/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAvatar extends StatelessWidget {
  const MAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        child: IconButton(
          icon: Image.asset('assets/icons/avatar.png'),
          onPressed: Get.find<HomeController>().toProfilePage,
        ),
      ),
    );
  }
}
