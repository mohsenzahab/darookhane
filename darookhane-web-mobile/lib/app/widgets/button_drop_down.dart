import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/models/specialty.dart';
import 'package:flutter/material.dart';

class MDropDownButton extends StatelessWidget {
  const MDropDownButton(
      {Key? key,
      required this.items,
      this.onChanged,
      this.value,
      required this.hint})
      : super(key: key);

  final String hint;
  final List<Specialty> items;
  final Specialty? value;
  final void Function(Specialty? selectedName)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Specialty>(
        value: value,
        hint: Text(hint),
        borderRadius: BorderRadius.circular(kBorderRadius),
        isExpanded: true,
        items: items
            .map((e) =>
                DropdownMenuItem<Specialty>(value: e, child: Text(e.name)))
            .toList(growable: false),
        onChanged: onChanged);
  }
}
