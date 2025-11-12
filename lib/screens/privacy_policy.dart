import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Last updated: November 12, 2025\n',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            const Text(
              'Thank you for using NumConvert – Base Converter. '
              'Your privacy is very important to us. This Privacy Policy explains how CodeByte Labs collects, uses, and protects your information when you use our mobile application.',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 24),
            _sectionTitle('1. Information We Collect'),
            const Text(
              'NumConvert does not collect or store any personally identifiable information. '
              'All conversion operations are processed locally on your device. '
              'However, we use Google Mobile Ads (AdMob) to display advertisements, '
              'which may collect limited, anonymous data as described below.',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 16),
            _sectionTitle('2. Third-Party Services'),
            const Text(
              'We use Google AdMob to serve advertisements within the app. '
              'AdMob may collect certain data such as device identifiers, ad interactions, '
              'and approximate location for the purpose of delivering personalized ads.\n\n'
              'For more details, please review Google\'s Privacy Policy:\n'
              'https://policies.google.com/privacy',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 16),
            _sectionTitle('3. Data Storage'),
            const Text(
              'All conversion history and user preferences are stored locally on your device. '
              'You may clear this data at any time through the app’s “Clear History” option. '
              'No personal or usage data is transmitted to our servers.',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 16),
            _sectionTitle('4. Children’s Privacy'),
            const Text(
              'NumConvert is suitable for general audiences and does not knowingly collect '
              'data from children under the age of 13. If you believe that a child has provided us '
              'with personal information, please contact us so that we can take appropriate action.',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 16),
            _sectionTitle('5. Changes to This Policy'),
            const Text(
              'We may update this Privacy Policy from time to time to reflect changes '
              'in our practices or for other operational, legal, or regulatory reasons. '
              'Any updates will be posted within the app along with a revised “Last updated” date.',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 16),
            _sectionTitle('6. Contact Us'),
            const Text(
              'If you have any questions, concerns, or requests regarding this Privacy Policy, '
              'please contact us at:\n\nsupport@codebytelabs.com\n\n'
              'CodeByte Labs\nSri Lanka',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 32),
            Center(
              child: Text(
                '© 2025 CodeByte Labs. All rights reserved.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
