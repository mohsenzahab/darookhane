import 'package:darookhane/app/core/themes/decoration.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({Key? key, this.child, this.height}) : super(key: key);

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      constraints: const BoxConstraints(
          maxWidth: kFormMaxWidth, minWidth: kFormMinWidth),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: kDecorationForm,
      child: FractionallySizedBox(
        widthFactor: .95,
        child: child,
      ),
    );
  }
}
