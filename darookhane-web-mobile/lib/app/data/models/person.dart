import 'dart:convert';

import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/provider/fields.dart';
import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({
    this.id,
    required this.userName,
    required this.name,
    required this.gender,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String name;
  @HiveField(3)
  Gender gender;

  Map<String, dynamic> toMap() => {
        if (id != null) F_ID: id,
        F_NAME: name,
        F_USERNAME: userName,
        F_GENDER: gender.name,
      };

  Person.fromMap(Map<String, dynamic> map)
      : id = map[F_ID],
        userName = map[F_USERNAME].toString(),
        name = map[F_NAME],
        gender = Gender.nameToGender(map[F_GENDER]);

  String toJson() {
    return jsonEncode(toMap());
  }
}
