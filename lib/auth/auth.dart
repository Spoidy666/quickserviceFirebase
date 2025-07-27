import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickservice/Components/snackBar.dart';
import 'package:quickservice/Navigation/mainPage.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';
import 'package:quickservice/loginOrsignup/signUp.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Mainpage();
            } else {
              return const Loginpage();
            }
          }),
    );
  }
}

User? getCurrentUser() {
  return FirebaseAuth.instance.currentUser;
}


void login(context, String email, String password) async {
  showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (context.mounted) {
      Navigator.pop(context);
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    snack(context, getFriendlyErrorLogin(e.code));
  }
}

void registerUser(context, String name, String email, String password,
    String confirmPassword) async {
  showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
  if (password != confirmPassword) {
    Navigator.of(context).pop();
    snack(context, "Password doesn't match");
  } else {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      snack(context, getFriendlyErrorSignUp(e.code));
    }
  }
}

// Future<void> createUserDocument(
//     UserCredential? userCredential, String name) async {
//   if (userCredential != null && userCredential.user != null) {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(userCredential.user!.email)
//         .set({'email': userCredential.user!.email, 'username': name});
//   }
// }
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


//Provider authentication is in provider page


