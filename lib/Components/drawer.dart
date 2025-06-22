import 'package:flutter/material.dart';
import 'package:quickservice/Navigation/mainPage.dart';
import 'package:quickservice/auth/auth.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
        ),
      ),
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      child: Icon(
                        Icons.person,
                        size: 60,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          getCurrentUser()!.displayName.toString(),
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Center(
                          child: Text(
                            getCurrentUser()!.email.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Theme.of(context).colorScheme.primary),
              title: Text(
                "Home",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Mainpage()));
              },
            ),
            ListTile(
                leading: Icon(Icons.history,
                    color: Theme.of(context).colorScheme.primary),
                title: Text("Booking",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onTap: () {}),
            Divider(),
            ListTile(
              leading: Icon(Icons.help,
                  color: Theme.of(context).colorScheme.primary),
              title: Text("Help and support",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review,
                  color: Theme.of(context).colorScheme.primary),
              title: Text("Become a provider",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
