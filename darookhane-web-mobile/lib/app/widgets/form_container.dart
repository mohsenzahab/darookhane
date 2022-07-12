import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxWidth: kFormMaxWidth, minWidth: kFormMaxWidth),
      alignment: Alignment.center,
      decoration: kDecorationForm,
      child: FractionallySizedBox(
        widthFactor: .95,
        child: child,
      ),
    );
  }
}
