import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/data/provider/fields.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Reservation {
  Reservation(
      {this.id,
      required this.date,
      required this.doctor,
      this.visited = false});

  int? id;
  final Jalali date;
  bool visited;
  final Doctor doctor;

  Reservation.fromMap(Map<String, dynamic> map)
      : id = map[F_ID],
        date = DateHelper.parse(map[F_DATE]),
        visited = map[F_VISITED] == 1,
        doctor = Doctor.fromMap(map[F_DOCTOR]);

  Map<String, dynamic> toMap() => {F_DATE: date.toData, F_DOCTOR_ID: doctor.id};
}
