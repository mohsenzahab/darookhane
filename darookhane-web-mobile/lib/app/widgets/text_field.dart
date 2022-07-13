import 'package:darookhane/app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class MTextField extends StatelessWidget {
  const MTextField(
      {Key? key,
      this.labelText,
      this.initialValue,
      this.onSaved,
      this.inputType = TextInputType.text})
      : super(key: key);

  final String? labelText;
  final void Function(String? s)? onSaved;
  final TextInputType inputType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: kStyleInputText,
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (str) {
        if (str == null || str.trim().isEmpty) return "Wrong input";
        return null;
      },
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            labelText: labelText,
          ),
    );
  }
}
