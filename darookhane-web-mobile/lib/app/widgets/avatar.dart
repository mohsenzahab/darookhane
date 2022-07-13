import 'package:darookhane/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAvatar extends StatelessWidget {
  const MAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: Container(
        height: 90.0,
        width: 90.0,
        color: Color.fromARGB(255, 136, 216, 211),
        child: IconButton(
          icon: Image.asset('assets/icons/avatar.png'),
          onPressed: Get.find<HomeController>().toProfilePage,
        ),
      ),
    );
  }
}
