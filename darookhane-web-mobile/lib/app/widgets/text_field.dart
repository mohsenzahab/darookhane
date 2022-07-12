import 'package:darookhane/app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class MTextField extends StatelessWidget {
  const MTextField(
      {Key? key, this.hintText, this.onSaved, this.isPhonNumber = false})
      : super(key: key);

  final String? hintText;
  final void Function(String? s)? onSaved;
  final bool isPhonNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kStyleInputText,
      onSaved: onSaved,
      validator: (str) {
        if (str == null || str.trim().isEmpty) return "Wrong input";
        return null;
      },
      textInputAction: TextInputAction.next,
      keyboardType: isPhonNumber ? TextInputType.phone : TextInputType.text,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            hintText: hintText,
          ),
    );
  }
}
