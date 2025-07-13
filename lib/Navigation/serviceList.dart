import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';

class Servicelist extends StatelessWidget {
  final String serviceLabel;
  const Servicelist({super.key, required this.serviceLabel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: CustomAppBar(textValue: serviceLabel),
      body: Center(
        child: Text(
            "Available providers will be listed here for \n                         $serviceLabel"),
      ),
    );
  }
}
