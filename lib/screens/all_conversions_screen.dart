import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import for clipboard
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

    AdInterstitial.handleConversion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Conversions'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Input Card - Fixed height content
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'Enter Number',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.numbers),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                            ),
                            onSubmitted: (_) => convertAll(),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: fromBase,
                            decoration: const InputDecoration(
                              labelText: 'From Base',
                              border: OutlineInputBorder(),
                            ),
                            items: ['Binary', 'Octal', 'Decimal', 'Hexadecimal']
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              _getBaseNumber(e),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(e),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (v) => setState(() => fromBase = v!),
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: convertAll,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.autorenew),
                                SizedBox(width: 8),
                                Text('Convert All'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Results Section - Adapts to content
                  if (results.isNotEmpty) ...[
                    Row(
                      children: [
                        Text(
                          'Conversion Results',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            results.length.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Flexible container that adapts to content height
                    Flexible(
                      fit: FlexFit.loose,
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: results.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: results.entries.length,
                                  separatorBuilder: (context, index) => const Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final entry = results.entries.elementAt(index);
                                    return ListTile(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                                      leading: Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primaryContainer,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          _getBaseNumber(entry.key),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                          ),
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          Text(
                                            entry.key,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.surfaceVariant,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Base ${_getBaseNumber(entry.key)}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        entry.value,
                                        style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          _copyToClipboard(entry.value, context);
                                        },
                                        icon: Icon(
                                          Icons.content_copy,
                                          size: 20,
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                        tooltip: 'Copy to clipboard',
                                      ),
                                      onTap: () {
                                        _copyToClipboard(entry.value, context);
                                      },
                                    );
                                  },
                                )
                              : const SizedBox(), // Fallback empty container
                        ),
                      ),
                    ),
                  ] else ...[
                    // Empty state - takes remaining space
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Enter a number to see all conversions',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
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

  String _getBaseNumber(String base) {
    switch (base) {
      case 'Binary': return '2';
      case 'Octal': return '8';
      case 'Decimal': return '10';
      case 'Hexadecimal': return '16';
      default: return '#';
    }
  }

  void _copyToClipboard(String text, BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied: $text'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to copy: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}