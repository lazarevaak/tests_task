import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../dto/transaction_dto.dart';

class TransactionsDao {
  static const String _key = 'transactions';

  Future<void> save(List<TransactionDto> transactions) async {
    final prefs = await SharedPreferences.getInstance();

    final data = transactions
        .map((t) => jsonEncode(t.toMap()))
        .toList();

    await prefs.setStringList(_key, data);
  }

  Future<List<TransactionDto>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];

    return stored
        .map((raw) =>
            TransactionDto.fromMap(jsonDecode(raw)))
        .toList();
  }
}
