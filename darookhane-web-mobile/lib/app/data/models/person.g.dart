// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 1;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      id: fields[0] as int?,
      userName: fields[1] as String,
      name: fields[2] as String,
      gender: fields[3] as Gender,
      // password: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
          ..writeByte(5)
          ..writeByte(0)
          ..write(obj.id)
          ..writeByte(1)
          ..write(obj.userName)
          ..writeByte(2)
          ..write(obj.name)
          ..writeByte(3)
          ..write(obj.gender)
          ..writeByte(4)
        // ..write(obj.password)
        ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
