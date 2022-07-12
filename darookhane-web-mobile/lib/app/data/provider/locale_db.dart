import 'package:darookhane/app/data/models/patient.dart';
import 'package:hive/hive.dart';

class LocalDB {
  LocalDB._();

  static late final LocalDB? _instance;

  LocalDB get instance {
    _instance ??= LocalDB._();
    return _instance!;
  }

  static const String _box_preferences = 'preferences';
  static const String _box_user_data = 'user_data';

  static const String _key_token = 'token';
  static const String _key_patient = 'patient';

  Future<String?> getLoggedInUserToken() async {
    final box = await Hive.openBox(_box_preferences);
    return box.get(_key_token);
  }

  Future<Patient?> get patientData async {
    final box = await Hive.openBox<Patient>(_box_user_data);
    return box.get(_key_patient);
  }

  void setPatientData(Patient patientData, String token) {
    Hive.openBox<Patient>(_box_user_data).then((box) => box.add(patientData));
    Hive.openBox(_box_preferences).then((box) => box.put(_key_token, token));
  }
}
