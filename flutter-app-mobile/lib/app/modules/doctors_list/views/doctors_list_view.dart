import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/doctors_list_controller.dart';

class DoctorsListView extends GetView<DoctorsListController> {
  const DoctorsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DoctorsListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DoctorsListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
