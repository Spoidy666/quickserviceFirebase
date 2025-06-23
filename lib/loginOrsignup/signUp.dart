import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:quickservice/Components/buttonOne.dart';
import 'package:quickservice/Components/snackBar.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

bool show_confirm_password = true;
final _signUpNameController = TextEditingController();
final _signUpEmailController = TextEditingController();
final _signUpPasswordController = TextEditingController();
final _signUpConfirmPasswordController = TextEditingController();

final class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Form(
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
                      obscureText: showPassword,
                      controller: _signUpPasswordController,
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
                                setState(showConfirmPasswordFunction);
                              },
                              icon:
                                  Icon(Icons.visibility, color: Colors.black)),
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
                      registerUser(context);
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
      ),
    );
  }
}

showConfirmPasswordFunction() {
  show_confirm_password = !show_confirm_password;
}

void registerUser(context) async {
  showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
  if (_signUpConfirmPasswordController.text != _signUpPasswordController.text) {
    Navigator.of(context).pop();
    snack(context, "Password doesn't match");
  } else {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _signUpEmailController.text,
              password: _signUpPasswordController.text);
      createUserDocument(userCredential);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      snack(context, e.code);
    }
  }
}

Future<void> createUserDocument(UserCredential? userCredential) async {
  if (userCredential != null && userCredential.user != null) {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userCredential.user!.email)
        .set({
      'email': userCredential.user!.email,
      'username': _signUpNameController.text
    });
  }
}

signInWithGoogle() async {
  final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
  if (guser == null) {
    return;
  }
  final GoogleSignInAuthentication gAuth = await guser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
