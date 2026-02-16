class Transaction {
  final DateTime date;
  final String category;
  final String name;
  final double amount;
  final bool isIncome;

  Transaction({
    required this.date,
    required this.category,
    required this.name,
    required this.amount,
    required this.isIncome,
  });
}
