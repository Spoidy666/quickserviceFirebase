import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Components/serviceCategory.dart';
import 'package:quickservice/Components/textField.dart';
import 'package:quickservice/auth/auth.dart';

class Becomeaprovider extends StatefulWidget {
  const Becomeaprovider({super.key});

  @override
  State<Becomeaprovider> createState() => _BecomeaproviderState();
}

class _BecomeaproviderState extends State<Becomeaprovider> {
  final providerNameController = TextEditingController();
  final providerEmailController = TextEditingController();
  final providerPhoneNumberController = TextEditingController();
  final experienceController = TextEditingController();
  final bioController = TextEditingController();
  ServiceCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    providerEmailController.text = getCurrentUser()!.email ?? '';
    providerNameController.text = getCurrentUser()!.displayName ?? '';
    providerPhoneNumberController.text = getCurrentUser()!.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(textValue: "Become a Provider"),
        drawer: drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("Become a Partner"),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Textfield(
                    hinttext: 'Full name',
                    textController: providerNameController,
                    textFieldIcon: Icons.person_2),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Textfield(
                    hinttext: 'Email',
                    textController: providerEmailController,
                    textFieldIcon: Icons.mail),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Textfield(
                    hinttext: 'Phone Number',
                    textController: providerPhoneNumberController,
                    textFieldIcon: Icons.phone),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: DropdownButtonFormField<ServiceCategory>(
                  value: selectedCategory,
                  onChanged: (ServiceCategory? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: ServiceCategory.values.map((ServiceCategory category) {
                    return DropdownMenuItem<ServiceCategory>(
                      value: category,
                      child: Text(category.label),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.build, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Select Service",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black),
                  iconEnabledColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Textfield(
                  hinttext: 'Years of Experience',
                  textController: experienceController,
                  textFieldIcon: Icons.timer,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  controller: bioController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Tell us about your experience",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }
}
