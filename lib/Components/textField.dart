import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController textController;
  final IconData textFieldIcon;
  const Textfield(
      {super.key,
      required this.hinttext,
      required this.textController,
      required this.textFieldIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
          prefixIcon: Icon(
            textFieldIcon,
            color: Colors.black,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
          fillColor: Colors.white,
          filled: true,
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.black)),
      style: TextStyle(color: Colors.black),
    );
  }
}
