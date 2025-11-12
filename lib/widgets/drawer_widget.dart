import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text('NumConvert', style: TextStyle(color: Colors.white, fontSize: 22)),
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Converter'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () => Navigator.pushReplacementNamed(context, '/history'),
          ),
          ListTile(
            leading: const Icon(Icons.all_inclusive),
            title: const Text('All Conversions'),
            onTap: () => Navigator.pushReplacementNamed(context, '/all'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
          ),
        ],
      ),
    );
  }
}
