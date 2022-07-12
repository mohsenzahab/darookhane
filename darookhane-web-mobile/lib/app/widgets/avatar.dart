import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MAvatar extends StatelessWidget {
  const MAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: Container(
        height: 70.0,
        width: 70.0,
        color: Color.fromARGB(255, 136, 216, 211),
        child: Icon(Icons.person, color: Colors.white, size: 50.0),
      ),
    );
  }
}
