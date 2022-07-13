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
        title: const Text('لیست رزور ها'),
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
        padding: const EdgeInsets.all(5),
        decoration: kDecorationForm.copyWith(color: Colors.tealAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(reservation.doctor.name),
                    Text(reservation.doctor.specialty.name)
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        DateHelper.format(
                            context, reservation.date.toDateTime()),
                      ),
                      Text(reservation.visited ? 'ویزیت شده' : 'ویزیت نشده')
                    ]),
              ]),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(
                'لغو',
              ),
              onPressed: reservation.visited
                  ? null
                  : () => Get.find<ReservationsController>()
                      .cancelReservation(reservation),
            ),
          ],
        ));
  }
}
