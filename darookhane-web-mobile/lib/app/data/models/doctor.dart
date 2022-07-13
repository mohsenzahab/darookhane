import 'package:darookhane/app/data/models/person.dart';
import 'package:darookhane/app/data/models/specialty.dart';
import 'package:darookhane/app/data/provider/fields.dart';

class Doctor extends Person {
  Doctor(
      {super.id,
      required super.userName,
      required super.name,
      required super.gender,
      // required super.password,
      required this.specialty});

  Specialty specialty;

  @override
  Map<String, dynamic> toMap() => {...super.toMap(), F_SPECIALTY: specialty};

  Doctor.fromMap(Map<String, dynamic> map, {bool withSpecialty = false})
      : specialty = Specialty.fromMap(map[F_SPECIALTY]),
        super.fromMap(map);
  Doctor.fromMapSpecialty(Map<String, dynamic> map, this.specialty)
      : super.fromMap(map);
}
