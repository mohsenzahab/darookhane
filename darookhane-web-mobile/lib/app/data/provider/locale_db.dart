import 'dart:convert';

import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/provider/fields.dart';
import 'package:hive/hive.dart';

class DB {
  DB._();

  static DB? _instance;

  static DB get db {
    _instance ??= DB._();
    return _instance!;
  }

  static const String _boxPreferences = 'preferences';
  // static const String _boxUserData = 'user_data';

  static const String _keyToken = 'token';
  static const String _keyPatient = 'patient';

  Future<String?> getLoggedInUserToken() async {
    final box = await Hive.openBox(_boxPreferences);
    return box.get(_keyToken);
  }

  Future<Patient?> get patientData async {
    final box = await Hive.openBox(_boxPreferences);
    return Patient.fromMap(jsonDecode(box.get(_keyPatient)));
  }

  void setPatientData(Patient patientData) {
    Hive.openBox(_boxPreferences).then((box) {
      box.put(_keyPatient, jsonEncode(patientData.toMap()));
      // box.put(F_USERNAME, patientData.userName);
      // box.put(F_NAME, patientData.name);
      // box.put(F_GENDER, patientData.gender);
      // box.put(F_ID, patientData.id);
      // box.put(F_BIRTHDATE, patientData.birthDate.toData);
    });
  }

  void setPatientToken(String token) {
    Hive.openBox(_boxPreferences).then((box) => box.put(_keyToken, token));
  }

  void clearLoginSession() {
    Hive.openBox(_boxPreferences).then((box) {
      box.delete(_keyToken);
    });
  }
}
