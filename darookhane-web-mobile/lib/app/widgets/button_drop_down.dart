import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:flutter/material.dart';

class MDropDownButton extends StatelessWidget {
  const MDropDownButton(
      {Key? key, required this.items, this.onChanged, required this.hint})
      : super(key: key);

  final String hint;
  final List<String> items;
  final void Function(String? selectedName)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        hint: Text(hint),
        borderRadius: BorderRadius.circular(kBorderRadius),
        isExpanded: true,
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(growable: false),
        onChanged: onChanged);
  }
}
