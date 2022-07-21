import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/specialty.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/data/models/medicine.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/models/prescription.dart';
import 'package:darookhane/app/data/models/reservation.dart';
import 'package:darookhane/app/data/provider/fields.dart';

class API {
  API._();

  static API? _instance;

  static API get api {
    _instance ??= API._();
    return _instance!;
  }

  final String _urlPrefix = 'https://mastouremast.ir';
  final String _authMethodBearer = 'Bearer';

// Adds the given patient to db.
  Future<ApiResponse> register(Patient patient) async {
    final url = Uri.parse('$_urlPrefix/api/register/patient');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final Response response =
        await post(url, headers: headers, body: patient.toJson())
            .then((response) {
      final map = jsonDecode(response.body);
      patient.id = map[F_ID];
      return response;
    });
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return ApiResponse(response);
  }

  Future<ApiResponse> updatePatient(String token, Patient patient) async {
    final url = Uri.parse('$_urlPrefix/api/patient/update');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };

    final response =
        await post(url, headers: headers, body: jsonEncode(patient.toMap()));
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return ApiResponse(response);
  }

// login user and return the token
  Future<ApiResponse> login(String userName, String password) async {
    final url = Uri.parse('$_urlPrefix/api/login');
    final headers = {
      // "Content-type": "application/json"
      "Accept": "application/json"
    };
    final json = {F_USERNAME: userName, F_PASSWORD: password};
    final response = await post(url, headers: headers, body: json);
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');

    return ApiResponse(response);
  }

  Future<Patient> getPatientData(String token) async {
    final url = Uri.parse('$_urlPrefix/api/patient');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    final map = jsonDecode(response.body);
    map[F_BIRTHDATE] = map[F_PATIENT][F_BIRTHDATE];
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return Patient.fromMap(map);
  }

  Future<List<Reservation>> getPatientReservations(
      String token, bool visited) async {
    final url = Uri.parse(
        '$_urlPrefix/api/patient/reservations?visited=${visited ? 'yes' : 'no'}');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    final maps = jsonDecode(response.body);
    debugPrint(response.body);
    List<Reservation> reservations = [];
    for (Map<String, dynamic> map in maps) {
      reservations.add(Reservation.fromMap(map));
    }
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return reservations;
  }

  Future<List<Prescription>> getPatientVisitsWithPrescriptions(
      String token) async {
    final url = Uri.parse('$_urlPrefix/api/patient/visits');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    List<Prescription> prescriptions = [];
    for (Map<String, dynamic> map in jsonDecode(response.body)) {
      prescriptions.add(Prescription.fromMap(
          map, await getPrescriptionsMedicines(token, map[F_PRESCRIPTION_ID])));
    }
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return prescriptions;
  }

  Future<List<Medicine>> getPrescriptionsMedicines(
      String token, String id) async {
    final url =
        Uri.parse('$_urlPrefix/api/patient/prescription/medicines?id=$id');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    List<Medicine> medicines = [];
    for (Map<String, dynamic> map in jsonDecode(response.body)) {
      medicines.add(Medicine.fromMap(map));
    }
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return medicines;
  }

  Future<Map<Specialty, List<Doctor>>> getDoctorsPerSpecialty(
      String token) async {
    final url = Uri.parse('$_urlPrefix/api/doctors');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    Map<Specialty, List<Doctor>> doctors = {};
    for (Map<String, dynamic> map in jsonDecode(response.body)) {
      final Specialty specialty = Specialty.fromMap(map);
      doctors[specialty] = [];
      log(map['doctors'].toString());
      for (Map<String, dynamic> map in map['doctors'].first) {
        doctors[specialty]!.add(Doctor.fromMapSpecialty(map, specialty));
      }
    }
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return doctors;
  }

  Future<List<Specialty>> getSpecialties(String token) async {
    final url = Uri.parse('$_urlPrefix/api/specialities');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    List<Specialty> doctors = [];
    log(response.body);
    for (Map<String, dynamic> map in jsonDecode(response.body)) {
      doctors.add(Specialty.fromMap(map));
    }
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return doctors;
  }

  Future<ApiResponse> createReservation(
      String token, Reservation reservation) async {
    final url = Uri.parse('$_urlPrefix/api/reserve');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };

    final response = await post(url,
        headers: headers, body: jsonEncode(reservation.toMap()));
    reservation.id = jsonDecode(response.body)[F_RESERVATION_ID];
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return ApiResponse(response);
  }
}

class ApiResponse {
  ApiResponse(Response response)
      : _body = jsonDecode(response.body),
        _statusCode = response.statusCode,
        _reason = response.reasonPhrase;

  static const int _ok = 200;
  static const int _created = 201;
  static const int _failed = 401;

  final int _statusCode;
  final String? _reason;
  // map or list
  final dynamic _body;

  Map<String, dynamic> get getMap => _body as Map<String, dynamic>;
  List<Map<String, dynamic>> get getList => _body as List<Map<String, dynamic>>;

  bool get isCreated => _statusCode == _created;
  bool get isFailed => _statusCode == _failed;
  bool get isOk => _statusCode == _ok;

  int get reserveId => _body[F_RESERVATION_ID];
  String get token => _body[F_TOKEN];
  int get id => _body[F_ID];
  String? get message => _body[F_MESSAGE];
  String get reason => _reason ?? "Empty";
  String get name => _body[F_NAME];
  String get userName => _body[F_USERNAME];
}
