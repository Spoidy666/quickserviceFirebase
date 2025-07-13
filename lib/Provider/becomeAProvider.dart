import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';

class Becomeaprovider extends StatelessWidget {
  const Becomeaprovider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(textValue: "Become a Provider"),
      drawer: drawer(),
      body: Column(children: [],),
    );
  }
}
