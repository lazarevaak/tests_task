import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_transaction_page.dart';
import 'transaction_details_page.dart';

void main() {
  runApp(const MoneyTrackerApp());
}

class MoneyTrackerApp extends StatelessWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class TransactionItem {
  final DateTime date;
  final String category;
  final String name;
  final double amount;
  final bool isIncome;

  TransactionItem({
    required this.date,
    required this.category,
    required this.name,
    required this.amount,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'category': category,
      'name': name,
      'amount': amount,
      'isIncome': isIncome,
    };
  }

  static TransactionItem fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as String,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
      isIncome: map['isIncome'] as bool,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

enum FilterType { all, income, losses }

class _MainPageState extends State<MainPage> {
  final List<TransactionItem> _transactions = [];
  FilterType _filterType = FilterType.all;
  String _query = '';
  static const String _prefsKey = 'transactions';

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  double get _balance {
    double total = 0;
    for (final t in _transactions) {
      total += t.isIncome ? t.amount : -t.amount;
    }
    return total;
  }

  List<TransactionItem> get _filteredTransactions {
    return _transactions.where((t) {
      final matchesFilter = _filterType == FilterType.all ||
          (_filterType == FilterType.income && t.isIncome) ||
          (_filterType == FilterType.losses && !t.isIncome);
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          t.name.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  Future<void> _openAddTransaction() async {
    final result = await Navigator.of(context).push<TransactionItem>(
      MaterialPageRoute(builder: (_) => const AddTransactionPage()),
    );
    if (result != null) {
      setState(() {
        _transactions.insert(0, result);
      });
      await _saveTransactions();
    }
  }

  void _openDetails(TransactionItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TransactionDetailsPage(item: item),
      ),
    );
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey) ?? [];
    final items = stored
        .map((raw) => TransactionItem.fromMap(
            jsonDecode(raw) as Map<String, dynamic>))
        .toList();
    if (!mounted) return;
    setState(() {
      _transactions
        ..clear()
        ..addAll(items);
    });
  }

  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final stored =
        _transactions.map((t) => jsonEncode(t.toMap())).toList();
    await prefs.setStringList(_prefsKey, stored);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTransactions;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTransaction,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('Balance', style: TextStyle(fontSize: 18)),
                    const Spacer(),
                    Text(
                      _balance.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _balance >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: _filterType == FilterType.all,
                    onSelected: (_) {
                      setState(() {
                        _filterType = FilterType.all;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Income'),
                    selected: _filterType == FilterType.income,
                    onSelected: (_) {
                      setState(() {
                        _filterType = FilterType.income;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Losses'),
                    selected: _filterType == FilterType.losses,
                    onSelected: (_) {
                      setState(() {
                        _filterType = FilterType.losses;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('No transactions'))
                  : ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return ListTile(
                          onTap: () => _openDetails(item),
                          title: Text(item.name),
                          subtitle: Text(
                            '${item.category} • ${item.date.toLocal().toString().split(' ').first}',
                          ),
                          trailing: Text(
                            (item.isIncome ? '+' : '-') +
                                item.amount.toStringAsFixed(2),
                            style: TextStyle(
                              color: item.isIncome ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
