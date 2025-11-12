import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // App logo
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/numconvert_transparent.png',
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'NumConvert',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Base Converter',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Navigation Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  _buildDrawerItem(
                    context,
                    Icons.calculate,
                    'Converter',
                    '/',
                  ),
                  _buildDrawerItem(
                    context,
                    Icons.history,
                    'History',
                    '/history',
                  ),
                  _buildDrawerItem(
                    context,
                    Icons.all_inclusive,
                    'All Conversions',
                    '/all',
                  ),
                  _buildDrawerItem(
                    context,
                    Icons.settings,
                    'Settings',
                    '/settings',
                  ),
                ],
              ),
            ),
          ),
          
          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    final isCurrentRoute = ModalRoute.of(context)?.settings.name == route;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrentRoute 
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isCurrentRoute 
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isCurrentRoute ? FontWeight.bold : FontWeight.normal,
            color: isCurrentRoute 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        trailing: isCurrentRoute
            ? Icon(
                Icons.circle,
                size: 8,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: () {
          Navigator.pop(context);
          if (!isCurrentRoute) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}