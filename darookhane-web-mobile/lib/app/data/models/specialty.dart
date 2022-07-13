import 'dart:convert';

import 'package:darookhane/app/data/provider/fields.dart';

class Specialty {
  Specialty({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  Specialty copyWith({
    int? id,
    String? name,
  }) {
    return Specialty(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      F_ID: id,
      F_NAME: name,
    };
  }

  factory Specialty.fromMap(Map<String, dynamic> map) {
    return Specialty(
      id: map[F_ID]?.toInt() ?? 0,
      name: map[F_NAME] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Specialty.fromJson(String source) =>
      Specialty.fromMap(json.decode(source));

  @override
  String toString() => 'Specialty(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Specialty && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
