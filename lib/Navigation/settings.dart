import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickservice/Navigation/profilePage.dart';
import 'package:quickservice/Provider/becomeAProvider.dart';
import 'package:quickservice/Theme/theme.dart';
import 'package:quickservice/bloc/themeCubit.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppBar(textValue: 'Settings'),
      drawer: const drawer(),
      body: BlocBuilder<Themecubit, ThemeData>(
        builder: (context, theme) {
          final isDarkMode = theme.brightness == Brightness.dark;

          return ListView(
            children: [
              _buildTile(
                context,
                icon: Icons.account_circle,
                title: 'Profile',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Profilepage()),
                ),
              ),
              _buildTile(
                context,
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildTile(
                context,
                icon: Icons.security,
                title: 'Privacy & Security',
                onTap: () {},
              ),
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                value: isDarkMode,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) {
                  if (value) {
                    context.read<Themecubit>().enableDarkMode();
                  } else {
                    context.read<Themecubit>().enableLightMode();
                  }
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Enable Color Theme',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                value: theme == colormode,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: isDarkMode
                    ? null // disable color theme if in dark mode
                    : (value) {
                        if (value == true) {
                          context.read<Themecubit>().enableColorMode();
                        } else {
                          context.read<Themecubit>().enableLightMode();
                        }
                      },
              ),
              _buildTile(context,
                  icon: Icons.handshake,
                  title: "Become a provider ", onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return Becomeaprovider();
                }));
              }),
              const Divider(),
              _buildTile(context,
                  icon: Icons.info, title: 'About', onTap: () {}),
              _buildTile(
                context,
                icon: Icons.logout,
                title: 'Logout',
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: Text('Logout',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
