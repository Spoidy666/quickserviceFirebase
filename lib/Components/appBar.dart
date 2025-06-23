import 'package:flutter/material.dart';
import 'package:quickservice/Navigation/settings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String textValue;
  const CustomAppBar({super.key, required this.textValue});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu_rounded)),
      title: Text(
        textValue,
        style: TextStyle(fontSize: 21),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctxs) {
                return SettingsPage();
              }));
            },
            icon: Icon(
              Icons.person_2,
              color: Theme.of(context).colorScheme.primary,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
