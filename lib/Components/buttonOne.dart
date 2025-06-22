import 'package:flutter/material.dart';

class Buttonone extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const Buttonone({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: onTap,
        style:
            ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black)),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
