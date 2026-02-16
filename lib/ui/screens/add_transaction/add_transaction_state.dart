import 'package:tests_task/domain/entities/transaction.dart';

class AddTransactionState {
  final String name;
  final String category;
  final String amount;
  final DateTime date;
  final bool isIncome;

  AddTransactionState({
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  factory AddTransactionState.initial() {
    return AddTransactionState(
      name: '',
      category: '',
      amount: '',
      date: DateTime.now(),
      isIncome: true,
    );
  }

  AddTransactionState copyWith({
    String? name,
    String? category,
    String? amount,
    DateTime? date,
    bool? isIncome,
  }) {
    return AddTransactionState(
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  Transaction? toEntity() {
    final parsed = double.tryParse(amount);
    if (name.isEmpty || category.isEmpty || parsed == null) {
      return null;
    }

    return Transaction(
      name: name,
      category: category,
      amount: parsed.abs(),
      date: date,
      isIncome: isIncome,
    );
  }
}
