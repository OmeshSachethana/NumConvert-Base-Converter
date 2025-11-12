import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../utils/history_storage.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  const SettingsScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const DrawerWidget(),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: onThemeChanged,
          ),
          ListTile(
            title: const Text('Reset History'),
            leading: const Icon(Icons.delete_forever),
            onTap: () async {
              await HistoryStorage.clearHistory();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('History cleared')),
              );
            },
          ),
        ],
      ),
    );
  }
}
