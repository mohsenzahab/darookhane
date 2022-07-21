import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

const urlPrefix = 'https://mastouremast.ir';

Future<void> getAllPatients() async {
  final url = Uri.parse('$urlPrefix/api/patient/patients');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  Response response = await get(url, headers: headers);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
}

Future<void> getPatientData() async {
  final url = Uri.parse('$urlPrefix/api/patient');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };
  Response response = await get(url, headers: headers);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
}

Future<void> getPatientReservations() async {
  final url = Uri.parse('$urlPrefix/api/patient/reservations');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };
  Response response = await get(url, headers: headers);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${jsonDecode(response.body)}');
}

Future<void> getPatientVisitsWithPrescriptions() async {
  final url = Uri.parse('$urlPrefix/api/patient/visits');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };
  Response response = await get(url, headers: headers);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
}

Future<void> getPrescriptionsMedicines() async {
  final url = Uri.parse('$urlPrefix/api/patient/prescription/medicines?id=12');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };
  Response response = await get(url, headers: headers);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
}

Future<void> getDoctorsList() async {
  final url = Uri.parse('$urlPrefix/api/doctors');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };
  Response response = await get(url, headers: headers);
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
}

Future<void> createReservation() async {
  final url = Uri.parse('$urlPrefix/api/reserve');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };
  final json = '{'
      '"doctor_id": "2",'
      '"date": "1401-4-26"'
      '}';
  final response = await post(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}

Future<void> registerPatient() async {
  final url = Uri.parse('$urlPrefix/api/register/patient');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  final json = '{'
      '"name": "Mohsen",'
      '"username": "1974421",'
      '"gender": "male",'
      '"password": "abcd1234",'
      '"birthdate": "1350-8-17"'
      '}';
  final response = await post(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}

Future<void> updatePatient() async {
  final url = Uri.parse('$urlPrefix/api/patient/update');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer 10|2bcqr3Nf6t81j6G43fvtvz9BtFnPYf2Phxf9yfqW"
  };

  final json = '{'
      '"id":"17",'
      '"name": "MohsenZ",'
      '"username": "974421",'
      '"gender": "male",'
      '"password": "abcd1234",'
      '"birthdate": "1350-8-17"'
      '}';
  final response = await post(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}

Future<void> login() async {
  final url = Uri.parse('$urlPrefix/api/login');
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  final json = '{'
      '"username": "974421",'
      '"password": "abcd1234"'
      '}';
  final response = await post(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}

void main(List<String> arguments) {
  // getAllPatients();
  // registerPatient();
  // login();
  // updatePatient();
  // getPatientData();
  // getPatientReservations();
  getPatientVisitsWithPrescriptions();
  // createReservation();
  // getDoctorsList();
}
