import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/auth/auth.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textValue: 'Profile'),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
                child: CircleAvatar(
              radius: 80,
              backgroundImage:
                  NetworkImage(getCurrentUser()!.photoURL.toString()),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                getCurrentUser()!.displayName.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              height: 400,
              width: 330,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your email"),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            style: BorderStyle.solid,
                            width: 2)),
                    color: Colors.grey[300],
                    child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Center(
                            child: Text(
                          getCurrentUser()!.email.toString(),
                          style: TextStyle(color: Colors.grey[800]),
                        ))),
                  ),
                  Text("Phone Number"),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            style: BorderStyle.solid,
                            width: 2)),
                    color: Colors.grey[300],
                    child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Center(
                            child: Text(
                          getCurrentUser()!.phoneNumber.toString(),
                          style: TextStyle(color: Colors.grey[800]),
                        ))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
