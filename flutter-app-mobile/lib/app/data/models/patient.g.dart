// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientAdapter extends TypeAdapter<Patient> {
  @override
  final int typeId = 2;

  @override
  Patient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    log('hive reading: reading values=> ${fields.toString()}');

    return Patient(
      id: fields[0] as int?,
      userName: fields[1] as String,
      gender: fields[3] as Gender,
      name: fields[2] as String,
      password: '',
      phoneNumber: '',
      birthDate: DateHelper.parse(fields[4]),
    );
  }

  @override
  void write(BinaryWriter writer, Patient obj) {
    log('hive write: writing values=> ${obj.toJson()}');
    writer
      // ..writeByte(5)
      ..writeByte(4)
      ..write(obj.birthDate.toString())
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
