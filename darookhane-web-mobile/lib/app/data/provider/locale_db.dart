import 'package:darookhane/app/data/models/patient.dart';
import 'package:hive/hive.dart';

class DB {
  DB._();

  static DB? _instance;

  static DB get db {
    _instance ??= DB._();
    return _instance!;
  }

  static const String _boxPreferences = 'preferences';
  static const String _boxUserData = 'user_data';

  static const String _keyToken = 'token';
  static const String _keyPatient = 'patient';

  Future<String?> getLoggedInUserToken() async {
    final box = await Hive.openBox(_boxPreferences);
    return box.get(_keyToken);
  }

  Future<Patient?> get patientData async {
    final box = await Hive.openBox<Patient>(_boxUserData);
    return box.get(_keyPatient);
  }

  void setPatientData(Patient patientData) {
    Hive.openBox<Patient>(_boxUserData)
        .then((box) => box.put(_keyPatient, patientData));
  }

  void setPatientToken(String token) {
    Hive.openBox(_boxPreferences).then((box) => box.put(_keyToken, token));
  }
}
