import 'package:hive/hive.dart';

part 'gender.g.dart';

@HiveType(typeId: 3)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female;

  static Gender nameToGender(String name) {
    if (name == Gender.male.name) {
      return Gender.male;
    } else {
      return Gender.female;
    }
  }
}
