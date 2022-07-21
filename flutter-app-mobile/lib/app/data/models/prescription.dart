import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/models/medicine.dart';
import 'package:darookhane/app/data/provider/fields.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'package:darookhane/app/data/models/doctor.dart';

class Prescription {
  Prescription({
    required this.prescriptionId,
    required this.date,
    required this.doctor,
    required this.medicine,
  });

  int prescriptionId;
  Jalali date;
  Doctor doctor;
  List<Medicine> medicine;

  Prescription.fromMap(Map<String, dynamic> map, List<Medicine> meds)
      : prescriptionId = map[F_PRESCRIPTION_ID],
        date = DateHelper.parse(map[F_DATE]),
        doctor = Doctor.fromMap(map[F_DOCTOR]),
        medicine = meds;
}
