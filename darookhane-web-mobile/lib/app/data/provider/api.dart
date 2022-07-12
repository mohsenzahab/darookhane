import 'dart:convert';
import 'dart:io';

import 'package:darookhane/app/core/utils/date_helper.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/data/models/medicine.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/models/prescription.dart';
import 'package:darookhane/app/data/models/reservation.dart';
import 'package:darookhane/app/data/provider/fields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shamsi_date/shamsi_date.dart';

class API {
  API._();

  static API? _instance;

  static API get instance {
    _instance ??= API._();
    return _instance!;
  }

  static const String result = "result";
  static const String message = "message";
  static const int _success = 201;
  final String _urlPrefix = 'https://mastouremast.ir';
  final String _authMethodBearer = 'Bearer';

// Adds the given patient to db.
  Future<Map<String, dynamic>> register(Patient patient) async {
    final url = Uri.parse('$_urlPrefix/api/register/patient');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final Response response =
        await post(url, headers: headers, body: patient.toMap().toString())
            .then((response) {
      final map = jsonDecode(response.body);
      patient.id = map[F_ID];
      return response;
    });
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return {result: response.statusCode == _success, message: response.body};
  }

  Future<bool> updatePatient(String token, Patient patient) async {
    final url = Uri.parse('$_urlPrefix/api/patient/update');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };

    final response =
        await post(url, headers: headers, body: patient.toMap().toString());
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return response.statusCode == _success;
  }

// login user and return the token
  Future<String> login(String userName, String password) async {
    final url = Uri.parse('$_urlPrefix/api/login');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final json = {F_USERNAME: userName, F_PASSWORD: password};
    final response = await post(url, headers: headers, body: json);
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return jsonDecode(response.body)[F_TOKEN];
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

  Future<List<Doctor>> getDoctorsList(String token) async {
    final url = Uri.parse('$_urlPrefix/api/doctors');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };
    Response response = await get(url, headers: headers);
    List<Doctor> doctors = [];
    for (Map<String, dynamic> map in jsonDecode(response.body)) {
      doctors.add(Doctor.fromMap(map));
    }
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    return doctors;
  }

  Future<bool> createReservation(String token, Reservation reservation) async {
    final url = Uri.parse('$_urlPrefix/api/reserve');
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "$_authMethodBearer $token"
    };

    final response =
        await post(url, headers: headers, body: reservation.toMap().toString());
    reservation.id = jsonDecode(response.body)[F_RESERVATION_ID];
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    return response.statusCode == _success;
  }
}
