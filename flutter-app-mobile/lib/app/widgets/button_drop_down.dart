import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/models/specialty.dart';
import 'package:flutter/material.dart';

class MDropDownButton extends StatelessWidget {
  const MDropDownButton(
      {Key? key,
      required this.items,
      this.fillColor,
      this.onChanged,
      this.value,
      required this.hint})
      : super(key: key);

  final String hint;
  final List<Specialty> items;
  final Specialty? value;
  final void Function(Specialty? selectedName)? onChanged;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Specialty?>(
        value: value,
        hint: Text(hint),
        decoration: const InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(fillColor: fillColor),
        borderRadius: BorderRadius.circular(kBorderRadiusVal),
        isExpanded: true,
        items: [
          const DropdownMenuItem<Specialty>(
              value: null,
              child: Text('همه تخصص‌ها',
                  style: const TextStyle(color: Colors.black))),
          ...items
              .map((e) => DropdownMenuItem<Specialty>(
                  value: e,
                  child: Text(
                    e.name,
                    style: const TextStyle(color: Colors.black),
                  )))
              .toList(growable: false)
        ],
        onChanged: onChanged);
  }
}
