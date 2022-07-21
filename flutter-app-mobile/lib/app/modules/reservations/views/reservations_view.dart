import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/models/reservation.dart';
import 'package:darookhane/app/widgets/form_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reservations_controller.dart';

class ReservationsView extends GetView<ReservationsController> {
  const ReservationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
        title: const Text(
          'لیست رزور ها',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FractionallySizedBox(
            widthFactor: .9,
            heightFactor: .9,
            child: FormContainer(
                child: Obx(() => ListView(
                      children: controller.reservations.value
                          .map((e) => ReservationCard(reservation: e))
                          .toList(),
                    )))),
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  const ReservationCard({Key? key, required this.reservation})
      : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: kDecorationForm.copyWith(color: kColorDoctorCard),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(reservation.doctor.name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                    Text(
                      reservation.doctor.specialty.name,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateHelper.format(
                            context, reservation.date.toDateTime()),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        reservation.visited ? 'ویزیت شده' : 'ویزیت نشده',
                        style: const TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w400),
                      )
                    ]),
              ]),
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //       padding: MaterialStateProperty.all(EdgeInsets.zero),
            //       backgroundColor: MaterialStateProperty.all(Colors.red)),
            //   child: Text(
            //     'لغو',
            //   ),
            //   onPressed: reservation.visited
            //       ? null
            //       : () => Get.find<ReservationsController>()
            //           .cancelReservation(reservation),
            // ),
          ],
        ));
  }
}
