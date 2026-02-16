import 'package:tests_task/domain/entities/transaction.dart';

enum FilterType { all, income, losses }

class MainState {
  final List<Transaction> transactions;
  final String query;
  final FilterType filter;

  MainState({
    required this.transactions,
    required this.query,
    required this.filter,
  });

  factory MainState.initial() {
    return MainState(
      transactions: [],
      query: '',
      filter: FilterType.all,
    );
  }

  MainState copyWith({
    List<Transaction>? transactions,
    String? query,
    FilterType? filter,
  }) {
    return MainState(
      transactions: transactions ?? this.transactions,
      query: query ?? this.query,
      filter: filter ?? this.filter,
    );
  }

  List<Transaction> get filtered {
    return transactions.where((t) {
      final matchesFilter = filter == FilterType.all ||
          (filter == FilterType.income && t.isIncome) ||
          (filter == FilterType.losses && !t.isIncome);

      final q = query.toLowerCase();
      final matchesQuery = q.isEmpty ||
          t.name.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q);

      return matchesFilter && matchesQuery;
    }).toList();
  }

  double get balance {
    double total = 0;
    for (final t in transactions) {
      total += t.isIncome ? t.amount : -t.amount;
    }
    return total;
  }
}
