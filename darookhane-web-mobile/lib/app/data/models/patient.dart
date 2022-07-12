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
      required super.password,
      required this.birthDate});

  // @HiveField(5)
  Jalali birthDate;

  @override
  Map<String, dynamic> toMap() =>
      {...super.toMap(), F_BIRTHDATE: birthDate.toData};

  Patient.fromMap(Map<String, dynamic> map)
      : birthDate = DateHelper.parse(map[F_BIRTHDATE]),
        super.fromMap(map);
}
