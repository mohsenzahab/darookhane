import 'package:darookhane/app/data/provider/fields.dart';

class Medicine {
  Medicine({this.id, required this.name, required this.price});

  int? id;
  String name;
  int price;

  Medicine.fromMap(Map<String, dynamic> map)
      : id = map[F_ID],
        name = map[F_NAME],
        price = map[F_PRICE];
}
