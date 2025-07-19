import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quickservice/Components/buttonOne.dart';
import 'package:quickservice/auth/auth.dart';
import 'package:quickservice/loginOrsignup/signUp.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _loginEmail = TextEditingController();
  final _loginPassword = TextEditingController();
  bool showPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginEmail.dispose();
    _loginPassword.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 250, child: Lottie.asset('assets/login.json')),
              Text(
                "Welcome",
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  controller: _loginEmail,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17)),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black),
                    obscureText: showPassword,
                    controller: _loginPassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          (Icons.lock),
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(Icons.visibility, color: Colors.black)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17)))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return Signup();
                          }));
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 00,
              ),
              Buttonone(
                  text: 'Login',
                  onTap: () {
                    login(context, _loginEmail.text, _loginPassword.text);
                  }),
              SizedBox(
                height: 20,
              ),
              Text('────── Or ──────'),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                width: 220,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 4,
                    ),
                    onPressed: () => signInWithGoogle(),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        Text(
                          '   Continue with Google',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not registered?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Signup();
                        }));
                      },
                      child: Text(
                        "Signup..",
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

String getFriendlyErrorLogin(String code) {
  switch (code) {
    case 'user-not-found':
      return 'No user found for this email.';
    case 'wrong-password':
      return 'Incorrect password.';
    case 'invalid-email':
      return 'Invalid email format.';
    default:
      return 'Something went wrong. ($code)';
  }
}
