import 'package:donor_app/constants.dart';
import 'package:flutter/material.dart';

class TextFieldCard extends StatelessWidget {
  final Widget childWidget;
  final bool isButton;

  TextFieldCard({
    required this.childWidget,
    required this.isButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isButton ? 220 : double.infinity,
      height: isButton ? 40 : 50,
      decoration: BoxDecoration(
        color: isButton ? kPrimaryColor : const Color(0x0f000000),
        borderRadius: BorderRadius.circular(10),
      ),
      child: childWidget,
    );
  }
}