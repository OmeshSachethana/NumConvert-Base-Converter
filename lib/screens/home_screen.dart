import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/ad_banner.dart';
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

  void convert() async {
    final input = _controller.text.trim();
    final output = BaseConverter.convert(input, fromBase, toBase);
    setState(() => result = output);
    await HistoryStorage.addHistory('$input ($fromBase)', '$output ($toBase)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Base Converter')),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Number',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildDropdown('From', fromBase, (v) => setState(() => fromBase = v!))),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('To', toBase, (v) => setState(() => toBase = v!))),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: convert, child: const Text('Convert')),
            const SizedBox(height: 10),
            if (result.isNotEmpty)
              Text('Result: $result', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            const AdBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: ['Binary', 'Octal', 'Decimal', 'Hexadecimal']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
