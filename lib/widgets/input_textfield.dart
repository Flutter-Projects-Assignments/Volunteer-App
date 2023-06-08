import 'package:donor_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  late String hintText;
  late bool hideText;
  late Widget? icon;
  late Widget? suffix;
  late TextInputType keyboardType;
  late TextEditingController controller;
  late Function(String) onChanged;
  late Function()? onEditingComplete;

  InputTextField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.controller,
      required this.hideText,
      required this.onChanged,
      this.icon,
      this.suffix,
      this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        obscureText: hideText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          suffix: suffix,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: kTextColor.withOpacity(0.5),
              )),
          hintText: hintText,
          prefixIcon: icon,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return hintText;
          }
          return null;
        },
        style: kTextStlye(FontWeight.normal, 16, kTextColor),
        // textAlign: SelectLanguage.isEng ? TextAlign.start : TextAlign.end,
      ),
    );
  }
}
