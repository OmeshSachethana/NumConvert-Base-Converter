import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/ad_banner.dart';
import '../widgets/ad_interstitial.dart';
import '../utils/converter.dart';
import '../utils/history_storage.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String fromBase = 'Decimal';
  String toBase = 'Binary';
  String result = '';
  String steps = '';

  void convert() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    final map = BaseConverter.convertWithSteps(input, fromBase, toBase);
    setState(() {
      result = map['result'] ?? '';
      steps = map['steps'] ?? '';
    });
    await HistoryStorage.addHistory('$input ($fromBase)', '$result ($toBase)');

    AdInterstitial.handleConversion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Converter'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Converter Card
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Input Field
                          TextField(
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Enter Number',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.numbers),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                              hintText: 'e.g., 255, 1010, FF, 377',
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Base Selection
                          Row(
                            children: [
                              Expanded(
                                child: _buildBaseDropdown(
                                  'From',
                                  fromBase,
                                  (v) => setState(() => fromBase = v!),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.arrow_forward,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildBaseDropdown(
                                  'To',
                                  toBase,
                                  (v) => setState(() => toBase = v!),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          // Convert Button
                          FilledButton(
                            onPressed: convert,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.autorenew),
                                SizedBox(width: 8),
                                Text(
                                  'Convert',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Results Section
                  if (result.isNotEmpty) ...[
                    Text(
                      'Conversion Result',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Result Card
                    Card(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Successfully Converted',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                result,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Steps Expansion
                    Card(
                      elevation: 2,
                      child: ExpansionTile(
                        leading: const Icon(Icons.info_outline),
                        title: const Text('Conversion Steps'),
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: SelectableText(
                              steps,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Empty State
                    const Center(
                      child: Column(
                        children: [
                          Icon(Icons.auto_awesome, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Enter a number to start converting',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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

  Widget _buildBaseDropdown(
    String label,
    String value,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items: ['Binary', 'Octal', 'Decimal', 'Hexadecimal']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}