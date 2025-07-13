import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Navigation/browseService.dart';
import 'package:quickservice/Navigation/homePage.dart';
import 'package:quickservice/Navigation/inbox.dart';
import 'package:quickservice/Navigation/settings.dart';
import 'package:quickservice/bloc/mainPageCubit.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});

  final _pages = [Homepage(), BrowseCategoryPage(), Inbox(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Mainpagecubit, int>(builder: (context, currentIndex) {
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          drawer: drawer(),
          body: _pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                context.read<Mainpagecubit>().changePage(value);
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
    });
  }
}
