import 'package:flutter/material.dart';
import '../utils/converter.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/ad_interstitial.dart';
import '../widgets/ad_banner.dart';

class AllConversionsScreen extends StatefulWidget {
  const AllConversionsScreen({super.key});

  @override
  State<AllConversionsScreen> createState() => _AllConversionsScreenState();
}

class _AllConversionsScreenState extends State<AllConversionsScreen> {
  final TextEditingController _controller = TextEditingController();
  String fromBase = 'Decimal';
  Map<String, String> results = {};

  void convertAll() {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      results = BaseConverter.convertAll(input, fromBase);
    });

    // Show interstitial ad every 3 conversions
    AdInterstitial.handleConversion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Conversions')),
      drawer: const DrawerWidget(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: fromBase,
                  decoration: const InputDecoration(labelText: 'From Base'),
                  items: ['Binary', 'Octal', 'Decimal', 'Hexadecimal']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => fromBase = v!),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: convertAll,
                  child: const Text('Convert All'),
                ),
                const SizedBox(height: 16),
                if (results.isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: results.entries
                          .map((e) => ListTile(
                                title: Text('${e.key}: ${e.value}'),
                              ))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),

          // Fixed Ad Banner at bottom
          const Align(
            alignment: Alignment.bottomCenter,
            child: AdBanner(),
          ),
        ],
      ),
    );
  }
}
