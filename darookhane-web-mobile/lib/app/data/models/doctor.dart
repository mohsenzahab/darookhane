import 'package:darookhane/app/data/models/person.dart';
import 'package:darookhane/app/data/provider/fields.dart';

class Doctor extends Person {
  Doctor(
      {super.id,
      required super.userName,
      required super.name,
      required super.gender,
      required super.password,
      required this.specialty});

  String specialty;

  @override
  Map<String, dynamic> toMap() => {...super.toMap(), F_SPECIALTY: specialty};

  Doctor.fromMap(Map<String, dynamic> map, {bool withSpecialty = false})
      : specialty = withSpecialty ? map[F_SPECIALTY] : map[F_SPECIALTY][F_NAME],
        super.fromMap(map);
}
