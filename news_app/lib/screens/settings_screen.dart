import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Dark Theme',
              style: TextStyle(color: const Color.fromARGB(255, 139, 136, 136)),
            ),
            trailing: Switch(
              value: themeNotifier.isDarkTheme,
              onChanged: (value) {
                themeNotifier.toggleTheme(); // Toggle theme
              },
            ),
          ),
        ],
      ),
    );
  }
}
