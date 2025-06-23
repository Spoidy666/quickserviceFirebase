import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quickservice/Components/buttonOne.dart';
import 'package:quickservice/Components/snackBar.dart';
import 'package:quickservice/loginOrsignup/signUp.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

bool showPassword = true;
final _loginEmail = TextEditingController();
final _loginPassword = TextEditingController();

class _LoginpageState extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: showPassword,
                      controller: _loginPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            (Icons.lock),
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(showPasswordFunction);
                              },
                              icon:
                                  Icon(Icons.visibility, color: Colors.black)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)))),
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
                      login(context);
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
      ),
    );
  }
}

showPasswordFunction() {
  showPassword = !showPassword;
}

void login(context) async {
  showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail.text, password: _loginPassword.text);
    if (context.mounted) {
      Navigator.pop(context);
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    snack(context, e.code);
  }
}
