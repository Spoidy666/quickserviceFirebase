import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:quickservice/Components/buttonOne.dart';
import 'package:quickservice/Components/snackBar.dart';
import 'package:quickservice/auth/auth.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final class _SignupState extends State<Signup> {
  bool show_confirm_password = true;
  bool show_password = true;
  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();
  final _SignUpformKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    _signUpNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Form(
          key: _SignUpformKey,
          child: Column(
            children: [
              SizedBox(height: 250, child: Lottie.asset('assets/login.json')),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  controller: _signUpNameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_2,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Username"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  controller: _signUpEmailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Email"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                    obscureText: show_password,
                    controller: _signUpPasswordController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          (Icons.lock),
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                show_password = !show_password;
                              });
                            },
                            icon: Icon(Icons.visibility, color: Colors.black)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                    controller: _signUpConfirmPasswordController,
                    obscureText: show_confirm_password,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          (Icons.lock),
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                show_confirm_password = !show_confirm_password;
                              });
                            },
                            icon: Icon(Icons.visibility, color: Colors.black)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)))),
              ),
              SizedBox(
                height: 20,
              ),
              Buttonone(
                  text: 'Sign Up',
                  onTap: () {
                    registerUser(
                        context,
                        _signUpNameController.text,
                        _signUpEmailController.text,
                        _signUpPasswordController.text,
                        _signUpConfirmPasswordController.text);
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Loginpage();
                        }));
                      },
                      child: Text(
                        "Already a user? Login",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getFriendlyErrorSignUp(String code) {
  switch (code) {
    case 'email-already-in-use':
      return 'This email is already registered.';
    case 'invalid-email':
      return 'Invalid email format.';
    case 'weak-password':
      return 'Password should be at least 6 characters.';
    default:
      return 'Something went wrong. ($code)';
  }
}
