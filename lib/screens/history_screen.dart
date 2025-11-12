import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../utils/history_storage.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await HistoryStorage.getHistory();
    setState(() => history = data);
  }

  Future<void> clearHistory() async {
    await HistoryStorage.clearHistory();
    setState(() => history = []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversion History')),
      drawer: const DrawerWidget(),
      body: history.isEmpty
          ? const Center(child: Text('No history yet'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final item = history[i];
                return ListTile(
                  title: Text('${item['input']} → ${item['output']}'),
                  subtitle: Text(item['time']),
                );
              }),
      floatingActionButton:
          FloatingActionButton(onPressed: clearHistory, child: const Icon(Icons.delete)),
    );
  }
}
