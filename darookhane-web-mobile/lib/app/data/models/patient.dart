import 'dart:developer';

import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/person.dart';
import 'package:darookhane/app/data/provider/fields.dart';
import 'package:hive/hive.dart';
import 'package:shamsi_date/shamsi_date.dart';

part 'patient.g.dart';

@HiveType(typeId: 2)
class Patient extends Person {
  Patient(
      {super.id,
      required super.userName,
      required super.gender,
      required super.name,
      required this.password,
      required this.phoneNumber,
      required this.birthDate});

  @HiveField(4)
  Jalali birthDate;
  String? password;
  String? phoneNumber;

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        F_BIRTHDATE: birthDate.toData,
        F_PASSWORD: password,
        F_PHONE: phoneNumber
      };

  Patient.fromMap(Map<String, dynamic> map)
      : birthDate = DateHelper.parse(map[F_BIRTHDATE]),
        password = map[F_PASSWORD],
        phoneNumber = map[F_PHONE],
        super.fromMap(map);
}
