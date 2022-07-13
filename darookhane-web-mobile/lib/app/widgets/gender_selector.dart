import 'package:darookhane/app/data/enums/gender.dart';
import 'package:flutter/material.dart';

class GenderSelectorForm extends StatelessWidget {
  const GenderSelectorForm({Key? key, required this.onChanged, this.value})
      : super(key: key);

  final void Function(Gender? newGender) onChanged;
  final Gender? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
        value: value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: [
          DropdownMenuItem(
            child: Text('مرد'),
            value: Gender.male,
          ),
          DropdownMenuItem(
            child: Text('زن'),
            value: Gender.female,
          ),
        ],
        validator: (gender) {
          if (gender == null) {
            return 'Gender must be provided';
          }
          return null;
        },
        onChanged: onChanged);
  }
}
