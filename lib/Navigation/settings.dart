import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Theme/theme_provider.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        textValue: 'Settings',
      ),
      drawer: drawer(),
      body: ListView(
        children: [
          _buildTile(
            icon: Icons.account_circle,
            title: 'Profile',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Loginpage()),
            ),
          ),
          _buildTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NotificationsPage()),
            ),
          ),
          _buildTile(
            icon: Icons.security,
            title: 'Privacy & Security',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PrivacyPage()),
            ),
          ),
          SwitchListTile(
            title: Text('Dark Mode',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            value: isDarkMode,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveThumbColor: Colors.grey,
            onChanged: (value) async {
              setState(() {
                isDarkMode = value;
              });
              await _saveThemePreference(value);
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          Divider(),
          _buildTile(
            icon: Icons.info,
            title: 'About',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AboutPage()),
            ),
          ),
          _buildTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
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
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
          TextButton(
            onPressed: () {
              logout();
              Navigator.pop(context);
            },
            child: Text('Logout',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}

// Dummy Pages
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Notifications')),
        body: Center(child: Text('Notifications Settings')));
  }
}

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Privacy & Security')),
        body: Center(child: Text('Privacy Settings')));
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About')),
        body: Center(child: Text('QuickService App\nVersion 1.0.0')));
  }
}

void logout() {
  FirebaseAuth.instance.signOut();
}
