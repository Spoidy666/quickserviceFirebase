import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Navigation/browseService.dart';
import 'package:quickservice/Navigation/homePage.dart';
import 'package:quickservice/Navigation/settings.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';
import 'package:quickservice/loginOrsignup/signUp.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _homeScreenState();
}

int _currentIndex = 0;
final _pages = [Homepage(), BrowseCategoryPage(), Loginpage(), SettingsPage()];

class _homeScreenState extends State<Mainpage> {
  dynamic _page = _pages[_currentIndex];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return Signup();
            }));
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        drawer: drawer(),
        body: _page,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.primary,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
                _page = _pages[_currentIndex];
              });
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_filled),
                icon: Icon(
                  Icons.home_outlined,
                  size: 24,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                  icon: Icon(
                    Icons.search_outlined,
                    size: 24,
                  ),
                  label: "Browse"),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.chat),
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 24,
                  ),
                  label: "Inbox"),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.settings),
                  icon: Icon(
                    Icons.settings_outlined,
                    size: 24,
                  ),
                  label: "Settings"),
            ]));
  }
}
