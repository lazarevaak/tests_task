class TransactionDto {
  final String name;
  final double amount;
  final bool isIncome;
  final String date;
  final String category;

  TransactionDto({
    required this.name,
    required this.amount,
    required this.isIncome,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'isIncome': isIncome,
      'date': date,
      'category': category,
    };
  }

  factory TransactionDto.fromMap(Map<String, dynamic> map) {
    return TransactionDto(
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(), // 🔥 важно
      isIncome: map['isIncome'] as bool,
      date: map['date'] as String,
      category: map['category'] as String,
    );
  }
}
