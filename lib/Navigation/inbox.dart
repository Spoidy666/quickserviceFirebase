import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textValue: 'Inbox'),
    );
  }
}
